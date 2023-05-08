# frozen_string_literal: true

module Api
  module V1
    class SalespeopleController < ApplicationController

       # GET /api/v1/salespeople
      def index
        @salespeople = Salesperson.all
        render json: @salespeople, status: :ok
      end

       # GET /api/v1/salespeople/:id
      def show
        @salesperson = Salesperson.find(params[:id])
        render json: @salesperson, status: :ok
      end

       # PUT /api/v1/sales/:id
      def update
        @salesperson = Salesperson.find(params[:id])
        if @salesperson.update(person_params)
          render json: @salesperson
        else
          render json: @salesperson.errors, status: :unprocessable_entity
        end
      end

      # GET /quarterly_commission_report?quarter=Q2&year=2023
      def quarterly_commission_report
        quarter = params[:quarter] # Q1, Q2, Q3, Q4
        year = params[:year].to_i

        commission_service = CommissionService.new(quarter, year)

        salesperson_data = commission_service.commission_report

        render json: salesperson_data, status: :ok
      end

      private
      # whitelisting the params
      def person_params
        params.require(:salesperson).permit(:first_name, :last_name, :address, :phone,
                                            :start_date, :termination_date, :manager_id)
      end
    end
  end
end
