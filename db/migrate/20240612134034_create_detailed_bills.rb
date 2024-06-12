class CreateDetailedBills < ActiveRecord::Migration[7.1]
  def change
    create_table :detailed_bills do |t|
      t.references :review, null: false, foreign_key: true
      t.string :item_description
      t.integer :amount
      t.float :price

      t.timestamps
    end
  end
end
