# == Schema Information
#
# Table name: specials
#
#  id                  :integer         not null, primary key
#  venue_id            :integer
#  name                :string(255)
#  description         :text
#  special_starts_at   :datetime
#  special_finishes_at :datetime
#  available_monday    :boolean
#  available_tuesday   :boolean
#  available_wednesday :boolean
#  available_thursday  :boolean
#  available_friday    :boolean
#  available_saturday  :boolean
#  available_sunday    :boolean
#  end_date            :datetime
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#

require 'spec_helper'

describe Special do
  
  before do
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

    @special = @venue.specials.create(
      name: "2 for 1 Drinks",
      description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
      tempor incididunt ut labore et dolore magna aliqua.",
      special_starts_at: Time.now - 1.hour,
      special_finishes_at: Time.now + 1.hour,
      available_sunday: false,
      available_monday: true,
      available_tuesday: true,
      available_wednesday: true,
      available_thursday: true,
      available_friday: true,
      available_saturday: false,
      end_date: nil
    )
  end

  subject { @special }


  it { should be_valid }
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:special_starts_at) }
  it { should respond_to(:special_finishes_at) }
  it { should respond_to(:available_sunday) }
  it { should respond_to(:available_monday) }
  it { should respond_to(:available_tuesday) }
  it { should respond_to(:available_wednesday) }
  it { should respond_to(:available_thursday) }
  it { should respond_to(:available_friday) }
  it { should respond_to(:available_saturday) }
  it { should respond_to(:end_date) }

  describe "name" do
    
    describe "should not be too short" do
      before { @special.name = 'a' }
      it { should_not be_valid }
    end

    describe "should not be too long" do
      before { @special.name = 'a'*200 }
      it { should_not be_valid }
    end
  end

  describe "description" do
    
    describe "should not be too short" do
      before { @special.description = 'a' }
      it { should_not be_valid }
    end

    describe "should not be too long" do
      before { @special.description = 'a'*400 }
      it { should_not be_valid }
    end

    describe "should allow blank description" do
      before { @special.description = "" }
      it { should be_valid }
    end    
  end
 
  


end
