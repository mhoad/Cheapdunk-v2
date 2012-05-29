module ReviewsHelper
  def display_stars(star)
    (1..5).inject("") do |output, i|
      output << radio_button_tag('star3',nil, i.eql?(star), :class => 'star', :disabled => true)
    end.html_safe
  end

  def average_rating(venue_id)
    @venue = Venue.find(venue_id)
    @average = 0
    if !@venue.reviews.empty?
      @venue.reviews.each do |review|
      @average = @average + review.rating
      end
      @average / @venue.reviews.count
    end
  end

  def average_rating_percent(average)
    @average_percent = (average.to_f / 5.to_f) * 100
    number_to_percentage(@average_percent, :precision => 0) 
  end
end