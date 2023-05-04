class Api::V1::SalespeopleController < ApplicationController

    def index
        @salespeople = Salesperson.all 
        # response.headers['X-Total-Count'] = @salespeople.count 
        render json: @salespeople, status: :ok 
      end 

      def show 
        @salesperson = Salesperson.find(params[:id])
        render json: @salesperson, status: :ok 
      end 
    
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

        start_date, end_date = get_quarter_dates(quarter, year)
        sales = Sale.where(sales_date: start_date..end_date)

        commission_data = get_commission_data(sales)

        salesperson_data = Salesperson.all.map do |salesperson|
          {
            name: "#{salesperson.first_name} #{salesperson.last_name}",
            quarterly_commission: commission_data[salesperson].try(:last) || 0,
            total_sales: commission_data[salesperson].try(:first) || 0
          }
        end
        
        render json: salesperson_data.sort_by {|data| data[:total_sales]}, status: :ok
      end


      private 

      def get_commission_data(sales)
        commission_data = sales.group_by(&:salesperson).transform_values do |sales|
          total_sales = 0
          commission = 0

          sales.sum do |sale|
            sale_price = sale.product.sale_price
            
            discounted_price = apply_discount(sale_price, sale.sales_date, sale.product.discounts)
            
            commission_percentage = sale.product.commission_percentage

            commission += (discounted_price * commission_percentage / 100)

            total_sales += discounted_price 

          end
          [total_sales, commission.round(2)]

        end
      end 


      #helper method to find discounted price 
      def apply_discount(sale_price, sale_date, product_discounts)

        discounts = product_discounts.where("begin_date <= ? AND end_date >= ?", sale_date.beginning_of_day, sale_date.end_of_day)
        discounted_price = sale_price 

        discounts && discounts.each do |discount|
          discounted_price -= discounted_price * (discount.discount_percentage / 100)
        end 
        discounted_price
      end

      # Helper method to calculate the start and end date of a quarter
      def get_quarter_dates(quarter, year)
        case quarter
        when 'Q1'
          [Date.new(year, 1, 1), Date.new(year, 3, 31)]
        when 'Q2'
          [Date.new(year, 4, 1), Date.new(year, 6, 30)]
        when 'Q3'
          [Date.new(year, 7, 1), Date.new(year, 9, 30)]
        when 'Q4'
          [Date.new(year, 10, 1), Date.new(year, 12, 31)]
        else
          raise ArgumentError, "Invalid quarter: #{quarter}"
        end
      end
    
    
      # whitelisting the params
      def person_params
        params.require(:salesperson).permit(:first_name, :last_name, :address, :phone, 
                        :start_date, :termination_date, :manager_id)
      end
end
