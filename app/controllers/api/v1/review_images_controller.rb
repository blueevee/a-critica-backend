class Api::V1::ReviewImagesController < ApplicationController
  before_action :set_review_image, only: [:destroy]

  def create
    @review = Review.find(params[:review_id])
    @review_image = @review.review_images.build(review_image_params)

    if @review_image.save
      render json: @review_image, status: :created
    else
      render json: @review_image.errors, status: :unprocessable_entity
    end
  end

  def index
    review_images = ReviewImage.where(review_id: params[:review_id])
    review_images = review_images.map { |ri| ri.image_url }
    render json: review_images
  end

  def destroy
    @review_image.destroy
    head :no_content
  end

  private

  def set_review_image
    @review_image = ReviewImage.find(params[:id])
  end

  def review_image_params
    params.require(:review_image).permit(:image_url, :review_id)
  end
end
