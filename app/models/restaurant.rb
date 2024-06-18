class Restaurant < ApplicationRecord
  has_many :reviews
  validates :name, :address, :background_image, presence: true
  validates :name, :address, :background_image, length: { minimum: 3 }
  end