require 'spec_helper'

describe VenuesController do

  before (:each) { @venue = FactoryGirl.create(:venue) }

  describe "GET 'show'" do
    
    it "should be successful" do
      get :show, :id => @venue.id
      response.should be_success
    end

    it "should find the right venue" do
      get :show, :id => @venue.id
      assigns(:venue).should == @venue
    end
  end

end
