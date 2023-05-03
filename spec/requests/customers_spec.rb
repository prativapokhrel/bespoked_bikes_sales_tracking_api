require 'rails_helper'

RSpec.describe 'Customers', type: :request do
    describe 'GET /index' do
      before do
        FactoryBot.create_list(:customer, 4)
        get '/api/v1/customers'
      end
      
      it 'returns all customers' do
        expect(json.size).to eq(4)
      end
  
      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end
  end
