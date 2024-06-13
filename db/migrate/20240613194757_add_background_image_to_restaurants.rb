class AddBackgroundImageToRestaurants < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurants, :background_image, :text
  end
end
