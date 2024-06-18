module RestaurantHandling
  def handle_cuisines(restaurant, cuisine_names)
    return unless cuisine_names
    cuisine_names.each do |cuisine_name|
      cuisine = Cuisine.find_or_create_by(cuisine_name: cuisine_name.downcase.capitalize)
      RestaurantCuisine.find_or_create_by(restaurant: restaurant, cuisine: cuisine)
    end
  end
end