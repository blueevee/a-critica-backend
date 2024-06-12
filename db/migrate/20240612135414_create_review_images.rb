class CreateReviewImages < ActiveRecord::Migration[7.1]
  def change
    create_table :review_images do |t|
      t.references :review, null: false, foreign_key: true
      t.string :image_url

      t.timestamps
    end
  end
end
