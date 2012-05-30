require 'spec_helper'

describe "Venue Pages" do

  subject { page }

  let(:venue) { FactoryGirl.create(:venue) }
  let(:submit) { "Submit" }
  let(:user) { FactoryGirl.create(:user) }

  before { user.add_role :admin } #Since only admins can add venues 

  describe "adding a venue" do
    before (:each) do
      sign_in user
      visit new_venue_path
    end

    describe "new venue page layout" do
      # The following tests check for a small sample of random elements under the 
      # assumption that if one is there they will all be there. If you are feeling
      # paranoid or have any need to just uncomment the appropriate lines
      # for a more comprehensive (and slower test suite)

      it { should have_selector('h1',     text: 'Submit a new venue') }
      it { should have_css('input#venue_name') }
      #it { should have_css('input#venue_email') }
      #it { should have_css('input#venue_street_address') }
      #it { should have_css('input#venue_suburb') }
      #it { should have_css('input#venue_postcode') }
      #it { should have_css('input#venue_phone_number') }
      it { should have_css('input#venue_url') }
      it { should have_css('textarea#venue_description') }
      it { should have_css('select#venue_trading_times_attributes_0_monday_opens_at_4i') }
      #it { should have_css('select#venue_trading_times_attributes_0_monday_closes_at_4i') }
      #it { should have_css('select#venue_trading_times_attributes_0_tuesday_opens_at_4i') }
      #it { should have_css('select#venue_trading_times_attributes_0_tuesday_closes_at_4i') }
      #it { should have_css('select#venue_trading_times_attributes_0_wednesday_opens_at_4i') }
      #it { should have_css('select#venue_trading_times_attributes_0_wednesday_closes_at_4i') }
      #it { should have_css('select#venue_trading_times_attributes_0_thursday_opens_at_4i') }
      #it { should have_css('select#venue_trading_times_attributes_0_thursday_closes_at_4i') }
      #it { should have_css('select#venue_trading_times_attributes_0_friday_opens_at_4i') }
      #it { should have_css('select#venue_trading_times_attributes_0_friday_closes_at_4i') }
      #it { should have_css('select#venue_trading_times_attributes_0_saturday_opens_at_4i') }
      #it { should have_css('select#venue_trading_times_attributes_0_saturday_closes_at_4i') }
      #it { should have_css('select#venue_trading_times_attributes_0_sunday_opens_at_4i') }
      it { should have_css('select#venue_trading_times_attributes_0_sunday_closes_at_4i') }
      it { should have_selector('input',  type: 'submit') }
    end

    describe "submiting the venue" do
      
      describe "with invalid information" do
        it "should not create a venue" do
          expect { click_button submit }.not_to change(Venue, :count)
        end
      end

      describe "with valid information" do
        before do
        fill_in "Name",             with: "Example Venue"
        fill_in "Email",            with: "user@example.com"
        fill_in "Street address",   with: "123 Example St"
        fill_in "Suburb",           with: "Sydney"
        fill_in "Postcode",         with: "2000"
        fill_in "Phone number",     with: "9528 2000"
        fill_in "Url",              with: "http://www.example.com/"
        fill_in "Description",      with: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, 
                                            sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        fill_in "Special Name",     with: "Example Special"  
        check "Monday"                                   
        end

        it "should create a venue" do
          expect { click_button submit }.to change(Venue, :count).by(1)
        end
      end      
    end
  end

  describe "editing the venue" do
    before do
      sign_in user
      visit edit_venue_path(venue)
      fill_in "Name", with: "Updated Venue"
      fill_in "Url",  with: "http://www.newvenueurl.com.au/"
      click_button submit
    end

    it { should have_content('Venue updated') } 
    it { should have_selector('h1', text: 'Updated Venue') }
    it { should have_content('http://www.newvenueurl.com.au/') }
  end

  describe "viewing a venue" do
    before { visit venue_path(venue) }

    describe "everyone can see the basic information" do
      it { should have_content(venue.name) }
      it { should have_content(venue.street_address) }
      it { should have_content(venue.postcode) }
      it { should have_content(venue.suburb) }
      it { should have_content(venue.phone_number) }
      it { should have_content(venue.url) }
    end

    describe "admins see the appropriate links" do
      before do
        sign_in user #Admin user
        visit venue_path(venue) 
      end
      it { should have_link("Edit Venue") }
      it { should have_link("Delete Venue") }
    end

    describe "regular users cannot see admin links" do
      before do
        user.revoke :admin 
        sign_in user #Regular user
        visit venue_path(venue) 
      end
      it { should_not have_link("Edit Venue") }
      it { should_not have_link("Delete Venue") }
    end
  end

  describe "User Authorisation" do
    before { user.revoke :admin }

    describe "regular users cannot add a new venue" do
      before { visit new_venue_path }

      it { should_not have_css('input#venue_name') }
      it { should have_content("You are not authorized to access this page") }
    end

    describe "regular users cannot edit a venue" do
      before { visit edit_venue_path(venue) }

      it { should_not have_css('input#venue_name') }
      it { should have_content("You are not authorized to access this page") }
    end
  end
end