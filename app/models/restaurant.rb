class Restaurant < ApplicationRecord
  has_many :reviews
  has_many :restaurantcuisines
  validates :name, :address, :background_image, presence: true
  validates :name, :address, :background_image, length: { minimum: 3 }
  end