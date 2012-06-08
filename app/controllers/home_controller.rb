class HomeController < ApplicationController
  def index
    @users = User.all
  end

  def terms_of_use
    
  end
end
