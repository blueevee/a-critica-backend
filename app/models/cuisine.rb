class Cuisine < ApplicationRecord
    validates :cuisine_name, length: { minimum: 3 }
    validates :cuisine_name, presence: true
end
