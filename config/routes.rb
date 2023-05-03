Rails.application.routes.draw do

  namespace :api do 
    namespace :v1 do 
      resources :products, only: [:index, :update, :edit]
      resources :salespeople, only: [:index, :update]
      resources :customers, only: [:index]
      resources :sales, only: [:index, :create]
    end 
  end 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
