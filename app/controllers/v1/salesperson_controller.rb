class V1::SalespersonController < ApplicationController

    def index
        @salespeople = Salesperson.all 
        render json: @salespeople, status: :ok 
      end 
    
      def update
        @salesperson = Salesperson.find(params[:id])
        if @salesperson.update(person_params)
          render json: @salesperson
        else
          render json: @salesperson.errors, status: :unprocessable_entity
        end
      end
    
      private 
    
      # whitelisting the params
      def person_params
        params.require(:salesperson).permit(:first_naem, :last_name, :address, :phone, 
                        :start_date, :termination_date, :manager_id)
      end
end
