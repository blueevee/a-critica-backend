class Api::V1::DetailedBillsController < ApplicationController
    def show
      billed_items = DetailedBill.where(review_id: params[:id])
      render json: billed_items
    end

    def create
      billed_item = DetailedBill.new(billed_item_params)

        if billed_item.save
          render json: {message: "Billed item was added successfully!", data: billed_item}, status: :created
        else
          render json: billed_item.errors, status: :unprocessable_content
        end
      end

      def destroy
        billed_item = DetailedBill.find(params[:id])
        billed_item.destroy
      end

      private

      def billed_item_params
        params.require(:detailed_bill).permit(:review_id, :item_description, :amount, :price)
      end
end