class Api::V1::DiscountsController < ApplicationController
    def index 
        @discounts = Discount.all 
        render json: @discounts, status: :ok
    end 

    def show 
        @discount = Discount.find(params[:id])
        render json: @discount, status: :ok
    end 

    def update 
        @discount = Discount.find(params[:id])
        if @discount.update(discount_params)
            render json: @discount, status: :ok
        else 
            render json: @discount.errors, status: :unprocessable_entity
        end 
    end 

    private 
     # whitelisting the params
    def discount_params
        params.require(:discount).permit(:product_id, :begin_date, :end_date, :discount_percentage)
    end 
end
