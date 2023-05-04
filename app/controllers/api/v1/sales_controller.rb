class Api::V1::SalesController < ApplicationController

     # GET /api/v1/sales
    def index 
        if params[:from_date] && params[:to_date] #date filter 
            from_date = Date.parse(params[:from_date])
            to_date = Date.parse(params[:to_date])
            @sales = Sale.where(sales_date: from_date.beginning_of_day..to_date.end_of_day).order(sales_date: :asc)
        else 
            @sales = Sale.all.order(sales_date: :asc)
        end 

            render json: @sales.as_json(
                methods: [:salesperson_commission, :discounted_price],
                include: {
                  product: {only: [:id, :name]},
                  salesperson: {only: [:first_name, :last_name]},
                  customer: {only: [:first_name, :last_name]}
                }
              ), status: :ok
              
    end 

     # GET /api/v1/sales/:id
    def show 
        @sale = Sale.find(params[:id])
        render json: @sale, status: :ok 
    end 

    def chart 
        @sales = []
        Sale.all.each do |sale|
            @sales << {sale_price: sale.discounted_price, 
                salesperson: "#{sale.salesperson.first_name} #{sale.salesperson.last_name}",
                sales_date: sale.sales_date}
        end 

        render json: @sales.sort_by { |data| data[:sales_date] }, status: :ok
    end 

     # POST /api/v1/sales
    def create 
        @sale = Sale.new(sales_params)

        if @sale.save
            render json: @sale, status: :created
        else
            render json: @sale.errors, status: :unprocessable_entity
        end
    end 

     # PUT /api/v1/sales/:id
    def update 
        @sale = Sale.find(params[:id])
        if @sale.update(sales_params)
            render json: @sale, status: :ok
        else 
            render json: @sale.errors, status: :unprocessable_entity
        end 
    end 

    private 

    # whitelisting the params
    def sales_params
        params.require(:sale).permit(:product_id, :salesperson_id, :customer_id, :sales_date) 
    end 
end
