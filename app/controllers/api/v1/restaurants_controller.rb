class Api::V1::RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:update]

    def index
        restaurants = Restaurant.all
        if restaurants
          render json: restaurants, status: :ok
        else
          render json: restaurants.errors, status: :bad_request
        end
    end

    def update
      if @restaurant.update(restaurants_params)
        render json: {message: "Restaurant was updated successfully!", data: @restaurant}, status: :ok
      else
        render json: @restaurant.errors, status: :unprocessable_entity
      end
    end

    def create
        restaurant = Restaurant.new(restaurants_params)

        if restaurant.save
          render json: {message: "Restaurant was added successfully!", data: restaurant}, status: :created
        else
          render json: restaurant.errors, status: :unprocessable_content
        end
      end

      private

      def set_restaurant
        @restaurant = Restaurant.find(params[:id])
      end

      def restaurants_params
        params.require(:restaurant).permit(:name, :address, :background_image)
      end
end