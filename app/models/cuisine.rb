class Cuisine < ApplicationRecord
    validates :cuisine_name, length: { minimum: 3 }
end
