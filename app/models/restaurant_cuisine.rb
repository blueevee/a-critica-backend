class RestaurantCuisine < ApplicationRecord
  belongs_to :restaurant
  belongs_to :cuisine
  validates :restaurant_id, :cuisine_id, presence: true
end
