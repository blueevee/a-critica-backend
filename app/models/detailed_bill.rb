class DetailedBill < ApplicationRecord
  belongs_to :review
  validates :review_id, :item_description, :amount, :price, presence: true
end
