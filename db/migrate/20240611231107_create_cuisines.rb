class CreateCuisines < ActiveRecord::Migration[7.1]
  def change
    create_table :cuisines do |t|
      t.string :cuisine_name

      t.timestamps
    end
  end
end
