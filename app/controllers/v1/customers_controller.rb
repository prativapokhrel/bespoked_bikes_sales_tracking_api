class V1::CustomersController < ApplicationController
    def index 
        @customers = Customer.all 
        render json: @customers, status: :ok
    end 

    private 

     # whitelisting the params
    def customer_params
        params.require(:customer).permit(:first_name, :last_name, :address, :phone, :start_date)
    end 
end
