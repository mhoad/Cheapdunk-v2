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
      it { should have_selector('h1',     text: 'Submit a new venue') }
      it { should have_selector('input',  id:   'venue_name') }
      it { should have_selector('input',  id:   'venue_email') }
      it { should have_selector('input',  id:   'venue_street_address') }
      it { should have_selector('input',  id:   'venue_suburb') }
      it { should have_selector('input',  id:   'venue_postcode') }
      it { should have_selector('input',  id:   'venue_phone_number') }
      it { should have_selector('input',  id:   'venue_url') }
      it { should have_selector('input',  id:   'venue_description') }
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
        fill_in "Name",              with: "Example Venue"
        fill_in "Email",             with: "user@example.com"
        fill_in "Street address",    with: "123 Example St"
        fill_in "Suburb",            with: "Sydney"
        fill_in "Postcode",          with: "2000"
        fill_in "Phone number",      with: "9528 2000"
        fill_in "Url",               with: "http://www.example.com/"
        fill_in "Description",       with: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, 
                                            sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
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

    it { should have_content(venue.name) }
    it { should have_content(venue.street_address) }
    it { should have_content(venue.postcode) }
    it { should have_content(venue.suburb) }
    it { should have_content(venue.phone_number) }
    it { should have_content(venue.url) }
  end

  describe "User Authorisation" do
    before { user.revoke :admin }

    describe "regular users cannot add a new venue" do
      before { visit new_venue_path }

      it { should_not have_selector('input',  id:   'venue_name') }
      it { should_not have_selector('input',  id:   'venue_name') }
      it { should have_content("You are not authorized to access this page") }
    end

    describe "regular users cannot edit a venue" do
      before { visit edit_venue_path(venue) }

      it { should_not have_selector('input',  id:   'venue_name') }
      it { should_not have_selector('input',  id:   'venue_name') }
      it { should have_content("You are not authorized to access this page") }
    end
  end
end