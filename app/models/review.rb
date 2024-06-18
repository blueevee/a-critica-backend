class Review < ApplicationRecord
  belongs_to :restaurant
  has_many :review_images
  has_many :detailed_bills
end
