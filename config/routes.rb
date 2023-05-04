Rails.application.routes.draw do

  namespace :api do 
    namespace :v1 do 

      get 'sales/chart' => 'sales#chart'
      resources :products, only: [:index, :update, :show]
      resources :salespeople, only: [:index, :update, :show]
      resources :customers, only: [:index, :show, :update]
      resources :sales, only: [:index, :create, :show, :update]
      resources :managers, only: [:index, :show, :update]
      resources :discounts, only: [:index, :show, :update]

      get 'quarterly_commission_report' => 'salespeople#quarterly_commission_report'
    end 
  end 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
