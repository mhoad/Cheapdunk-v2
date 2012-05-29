# == Schema Information
#
# Table name: venues
#
#  id             :integer         not null, primary key
#  name           :string(255)
#  description    :text
#  street_address :string(255)
#  postcode       :integer
#  suburb         :string(255)
#  url            :string(255)
#  email          :string(255)
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#  phone_number   :string(255)
#

require 'spec_helper'

describe Venue do
  
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
  end

  subject { @venue }

  it { should be_valid }
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:email) }
  it { should respond_to(:postcode) }
  it { should respond_to(:phone_number) }
  it { should respond_to(:url) }
  it { should respond_to(:suburb) }  
  it { should respond_to(:street_address) }

  describe "email" do
    it "should accept valid email addresses" do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      addresses.each do |valid_address|
          @venue.email = valid_address
          @venue.should be_valid
      end 
    end

    it "should not accept invalid email addresses" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |invalid_address|
          @venue.email = invalid_address
          @venue.should_not be_valid
      end 
    end
  end

  describe "URLs" do
    it "should accept valid URLs" do
       urls = %w[http://www.foobar.com http://www.google.com http://google.com/]
        urls.each do |valid_urls|
            @venue.url = valid_urls
            @venue.should be_valid
        end 
    end

    it "should not accept invalid URLs" do
      #dont accept short non http version
      urls = %w[www.foobar.com ftp://google.com http:/google.com/:80]
      urls.each do |invalid_urls|
        @venue.url = invalid_urls
        @venue.should_not be_valid
      end 
    end
  end

  describe "postcodes" do

    describe "with valid postcode" do
      before { @venue.postcode = 3000 }
      it { should be_valid }
    end

    it "should not accept invalid postcodes" do
      postcodes = %w[20000 300 four] 
      postcodes.each do |invalid_post_codes|
        @venue.postcode = invalid_post_codes
        @venue.should_not be_valid
      end 
    end
  end

  describe "suburbs" do

    it "should accept valid suburbs" do
      suburbs = %w[Sydney Melbourne Canberra Brisbane]
      suburbs.each do |valid_suburbs|
        @venue.suburb = valid_suburbs
        @venue.should be_valid
      end 
    end

    it "should not accept invalid suburbs" do
      suburbs = %w[ab sydn3y aaaaaaaaaaaaaaaaaaaaa] 
      suburbs.each do |invalid_suburbs|
        @venue.suburb = invalid_suburbs
        @venue.should_not be_valid
      end 
    end
  end

  describe "descriptions" do

    describe "should not be too short" do
      before { @venue.description = "a"*50 }
      it { should_not be_valid }
    end

    describe "should not be too long" do
      before { @venue.description = "a"*501 }
      it { should_not be_valid }
    end

    describe "should accept a valid description" do
      before { @venue.description = "a"*300 }
      it { should be_valid }
    end
  end

  describe "should not require non essential fields" do
    before { @venue.update_attributes(:email => "", :url => "", 
                                      :phone_number => "", :description => "") }
    it { should be_valid }
  end

  describe "should require essential fields" do
    before { @venue.update_attributes(:name => "", :postcode => "", :suburb => "") }
    it { should_not be_valid }
  end
end
