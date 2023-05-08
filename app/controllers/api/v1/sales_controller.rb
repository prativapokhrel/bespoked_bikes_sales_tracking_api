# frozen_string_literal: true

module Api
  module V1
    class SalesController < ApplicationController

      # GET /api/v1/sales
      def index
        sales_service = SalesService.new(params)
        render json: sales_service.as_json, status: :ok
      end

      # GET /api/v1/sales/:id
      def show
        @sale = Sale.find(params[:id])
        render json: @sale, status: :ok
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
  end
end
