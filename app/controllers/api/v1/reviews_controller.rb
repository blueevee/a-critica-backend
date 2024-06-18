class Api::V1::ReviewsController < ApplicationController

  def create
    review = Review.new(review_params)

    if review.save
      render json: {message: "Review was added successfully!", data: review}, status: :created
    else
      render json: review.errors, status: :unprocessable_content
    end
  end

  private

  def review_params
    params.require(:review).permit(:restaurant_id, :visit_date, :pseudonym, :comment, :rating)
  end

end
