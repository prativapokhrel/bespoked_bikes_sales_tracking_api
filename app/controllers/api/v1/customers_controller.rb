class Api::V1::CustomersController < ApplicationController
    def index 
        @customers = Customer.all 
        render json: @customers, status: :ok
    end 

    def show 
        @customer = Customer.find(params[:id])
        render json: @customer, status: :ok
    end 

    def update 
        @customer = Customer.find(params[:id])
        if @customer.update(customer_params)
            render json: @customer, status: :ok
        else 
            render json: @customer.errors, status: :unprocessable_entity
        end 
    end 

    private 

     # whitelisting the params
    def customer_params
        params.require(:customer).permit(:first_name, :last_name, :address, :phone, :start_date)
    end 
end
