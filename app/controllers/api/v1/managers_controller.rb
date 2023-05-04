class Api::V1::ManagersController < ApplicationController

    def index 
        @managers = Manager.all 
        render json: @managers, status: :ok
    end 

    def show 
        @manager = Manager.find(params[:id])
        render json: @manager, status: :ok
    end 

    def update 
        @manager = Manager.find(params[:id])
        if @manager.update(manager_params)
            render json: @manager
          else
            render json: @manager.errors, status: :unprocessable_entity
          end
    end 

    private 

    def manager_params
        params.require(:manager).permit(:email, :first_name, :last_name)
    end 
end
