class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.date :visit_date
      t.string :pseudonym
      t.text :comment
      t.float :rating

      t.timestamps
    end
  end
end
