class ReviewsController < ApplicationController
  def create  
    @venue = Venue.find(params[:venue_id])
    @review = @venue.reviews.new(params[:review].merge(:user_id => current_user.id))
    
    if @review.save
      flash[:success] = "Thanks for adding your review"
      redirect_to venue_path(params[:venue_id])
    else
      flash[:error] = "Please ensure your review is between 100 - 500 characters"
      redirect_to venue_path(params[:venue_id])
    end
  end

  def destroy
    Review.find(params[:id]).destroy
    flash[:success] = "Review deleted."
    redirect_to venue_path(params[:venue_id])
  end
end
