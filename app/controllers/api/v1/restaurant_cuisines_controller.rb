class Api::V1::RestaurantCuisinesController < ApplicationController
    before_action :set_restaurant_cuisine, only: [:destroy]

    def create
      @restaurant_cuisine = RestaurantCuisine.new(restaurant_cuisine_params)

      if @restaurant_cuisine.save
        render json: @restaurant_cuisine, status: :created
      else
        render json: @restaurant_cuisine.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @restaurant_cuisine.destroy
    end

    def show
        restaurant_cuisines = RestaurantCuisine.where(restaurant_id: params[:id])
        cuisines = restaurant_cuisines.map { |rc| rc.cuisine.cuisine_name }
        render json: cuisines
    end

    private

    def set_restaurant_cuisine
        @restaurant_cuisine = RestaurantCuisine.find_by(restaurant_id: params[:restaurant_id], cuisine_id: params[:cuisine_id])
    end

    def restaurant_cuisine_params
      params.require(:restaurant_cuisine).permit(:restaurant_id, :cuisine_id)
    end
  end
