class V1::SalesController < ApplicationController

    def index 
        @sales = Sale.all 
        render json: @sales, status: :ok 
    end 

    def create 
        @sale = Sale.new(sales_params)

        if @sale.save
            render json: @sale, status: :created
        else
            render json: @sale.errors, status: :unprocessable_entity
        end
    end 

    private 

    # whitelisting the params
    def sales_params
        params.require(:sales).permit(:product_id, :salesperson_id, :customer_id, :sales_date) 
    end 
end
