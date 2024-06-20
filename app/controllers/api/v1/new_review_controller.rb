class Api::V1::NewReviewController < ApplicationController
  include RestaurantHandling

  def create
    ActiveRecord::Base.transaction do
      if review_params[:restaurant][:id] > 0
        restaurant = Restaurant.find(review_params[:restaurant][:id])
        update_restaurant_if_needed(restaurant, review_params[:restaurant])
      else
        restaurant = Restaurant.create!(review_params[:restaurant].except(:cuisines))
        handle_cuisines(restaurant, review_params[:restaurant][:cuisines])
      end

      review_params[:reviews].each do |review_data|
        review = restaurant.reviews.create!(review_data.except(:images, :bill))
        review_data[:images].each do |image_url|
          review.review_images.create!(image_url: image_url)
        end
        review_data[:bill].each do |bill_item|
          review.detailed_bills.create!(bill_item)
        end
      end
    end
    rescue ActiveRecord::RecordInvalid => e
      render json: { errors: e.record.errors.full_messages }, status: :unprocessable_content
    end

  private


  def review_params
    params.require(:new_review).permit(restaurant: [:id, :name, :address, :background_image, cuisines: []], reviews: [:visit_date, :pseudonym, :comment, :rating, images: [], bill: [:item_description, :amount, :price]])
  end

  def restaurant_params(restaurant_data)
    restaurant_data.permit(:id, :name, :address, :background_image).merge(cuisines: restaurant_data[:cuisines].join(", "))
  end

  def update_restaurant_if_needed(restaurant, restaurant_data)
    restaurant.update!(restaurant_data.except(:cuisines)) if restaurant_data_differs?(restaurant, restaurant_data)
  end

  def restaurant_data_differs?(restaurant, restaurant_data)
    restaurant.name != restaurant_data[:name] ||
    restaurant.address != restaurant_data[:address] ||
    restaurant.background_image != restaurant_data[:background_image]
  end
end
