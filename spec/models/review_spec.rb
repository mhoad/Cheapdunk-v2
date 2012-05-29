# == Schema Information
#
# Table name: reviews
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  venue_id   :integer
#  comment    :text
#  rating     :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Review do

  before(:each) do
    @venue = Venue.create!(
      name: "Example Venue",
      description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
      tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
      quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
      consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
      cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
      proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      email:                   "venue@example.com",
      street_address:          "123 Fake St", 
      postcode:                2000,
      phone_number:            "9520 0000",
      url:                     "http://www.example.com/",
      suburb:                  "Sydney"
    )

    @user = User.create!( 
      :name                   => "Example User",
      :email                  => "user@example.com",
      :password               => "foobar",
      :password_confirmation  => "foobar",
      :oauth                  => false
      )

    @review = @venue.reviews.new(
      comment: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
      tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
      quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
      consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
      cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
      proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      rating:   2,
      user_id:  @user.id
    )
  end

  subject { @review }

  it { should respond_to(:comment) }
  it { should respond_to(:rating) }
  it { should respond_to(:user_id) }
  it { should respond_to(:venue_id) }
  it { should be_valid }
  

  describe "Comments" do

    describe "should require a comment" do
      before { @review.comment = "" }
      it { should_not be_valid }
    end

    describe "reviews should be at least 100 characters" do
      before { @review.comment = "a"*99 }
      it { should_not be_valid }
    end

    describe "reviews should be no longer than 500 characters" do
      before { @review.comment = "a"*501 }
      it { should_not be_valid }
    end

  end

  describe "Name" do
    describe "should require a name" do
      before { @review.user_id = "" }
      it { should_not be_valid }
    end
  end

  describe "Ratings" do
    it "shoud reject invalid ratings" do
      ratings = %w[one 8 0 -4]
      ratings.each do |invalid_ratings|
        @review.rating = invalid_ratings
        @review.should_not be_valid
      end 
    end
  end

end
