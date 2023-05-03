class V1::SalesController < ApplicationController

    def index 
        if params[:from_date] && params[:to_date]
            from_date = Date.parse(params[:from_date])
            to_date = Date.parse(params[:to_date])
            @sales = Sale.where(created_at: from_date.beginning_of_day..to_date.end_of_day)
        else 
            @sales = Sale.all 
        end 
       
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

    def filter_by_date
        @sales = Sale.where(created_at: from_date.beginning_of_day..to_date.end_of_day)
    end 

    private 

    # whitelisting the params
    def sales_params
        params.require(:sales).permit(:product_id, :salesperson_id, :customer_id, :sales_date) 
    end 
end
