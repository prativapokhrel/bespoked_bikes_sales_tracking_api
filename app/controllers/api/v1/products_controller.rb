class Api::V1::ProductsController < ApplicationController

   # GET /api/v1/products/:id
  def index
    @products = Product.all 
    render json: @products, status: :ok 
  end 

 # GET /api/v1/products/:id
  def show
    @product = Product.find(params[:id]) 
    render json: @product, status: :ok 
  end 

   # PUT /api/v1/products/:id
  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  private 

  # whitelisting the params
  def product_params
    params.require(:product).permit(:name, :manufacturer, :style, :purchase_price, :sale_price, :qty_on_hand, :commission_percentage)
  end
end
