module VenuesHelper
  def format_distance_from(distance)
    if distance < 1
      distance *= 100
      return number_with_precision(distance, :precision => 0) + " meters"
    else
      return number_with_precision(distance, :precision => 2) + " km"
    end
  end
end
