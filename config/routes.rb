# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'sales/chart' => 'sales#chart'
      resources :products, only: %i[index update show]
      resources :salespeople, only: %i[index update show]
      resources :customers, only: %i[index show update]
      resources :sales, only: %i[index create show update]
      resources :managers, only: %i[index show update]
      resources :discounts, only: %i[index show update]

      get 'quarterly_commission_report' => 'salespeople#quarterly_commission_report'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
