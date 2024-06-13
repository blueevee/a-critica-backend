class Api::V1::CuisinesController < ApplicationController
    def index
        cuisines = Cuisine.all
        if cuisines
          render json: cuisines, status: :ok
        else
          render json: cuisines.errors, status: :bad_request
        end
    end

    def create
        cuisine = Cuisine.new(cuisine_params)

        if cuisine.save
          render json: {message: "Cuisine was added successfully!", data: cuisine}, status: :created
        else
          render json: cuisine.errors, status: :unprocessable_entity
        end
      end

      private

      def cuisine_params
        params.require(:cuisine).permit(:cuisine_name)
      end
end