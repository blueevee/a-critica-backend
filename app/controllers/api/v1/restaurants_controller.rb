class Api::V1::RestaurantsController < ApplicationController
  include RestaurantHandling
  before_action :set_restaurant, only: [:update]

    def index
      restaurants = Restaurant.all.includes(:reviews)
      # , :restaurant_cuisines)

      restaurants_with_details = restaurants.map do |restaurant|
        {
          id: restaurant.id,
          name: restaurant.name,
          address: restaurant.address,
          reviews: restaurant.reviews.count,
          # cuisines: restaurant.restaurant_cuisines.map { |rc| rc.cuisine.cuisine_name },
          background_image: restaurant.background_image
        }
      end

      if restaurants_with_details
        render json: restaurants_with_details, status: :ok
      else
        render json: { error: 'Não foi possível recuperar os restaurantes' }, status: :bad_request
      end
    end

    def create
      restaurant = Restaurant.new(restaurants_params.except(:cuisines))

      if restaurant.save
        handle_cuisines(restaurant, restaurants_params[:cuisines])
        render json: {message: "Restaurant was added successfully!", data: restaurant}, status: :created
      else
        render json: restaurant.errors, status: :unprocessable_content
      end
    end

    def update
      if @restaurant.update(restaurants_params.except(:cuisines))
        handle_cuisines(@restaurant, restaurants_params[:cuisines])
        render json: {message: "Restaurant was updated successfully!", data: @restaurant}, status: :ok
      else
        render json: @restaurant.errors, status: :unprocessable_content
      end
    end

    def show
      restaurant = Restaurant.find(params[:id])
      restaurant_details = {
        restaurant: {
          address: restaurant.address,
          id: restaurant.id,
          background_image: restaurant.background_image,
          name: restaurant.name
        },
        reviews: restaurant.reviews.map do |review|
          {
            visit_date: review.visit_date,
            pseudonym: review.pseudonym,
            comment: review.comment,
            rating: review.rating,
            images: review.review_images.map(&:image_url),
            bill: review.detailed_bills.map do |bill|
              {
                item_description: bill.item_description,
                amount: bill.amount,
                price: bill.price
              }
            end
          }
        end
      }

      render json: restaurant_details, status: :ok
    end

    private

    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    def restaurants_params
      params.fetch(:restaurant, {}).permit(:name, :address, :background_image).merge(cuisines: params[:cuisines])
    end

end
