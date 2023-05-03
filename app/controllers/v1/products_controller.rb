class V1::ProductsController < ApplicationController

    def index
        @products = Product.all 
        render json: @products, status: :ok 
    end 
end
