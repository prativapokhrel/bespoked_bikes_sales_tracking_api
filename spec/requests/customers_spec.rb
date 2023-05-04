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

    describe 'PUT /update' do

      let!(:customer) { FactoryBot.create(:customer) }
      let(:valid_attributes) {{ first_name: "Ram", last_name: "Maney", start_date: Date.today }}
      let(:invalid_attributes) {{first_name: nil, last_name: "Man", start_date: Date.today}}

      context "when the request is valid" do 
          before do
              put "/api/v1/customers/#{customer.id}", params: {customer: valid_attributes}
          end
          
          it 'updates the customer' do
              customer.reload 
              expect(customer.first_name).to eq("Ram")
              expect(customer.last_name).to eq("Maney")
              expect(customer.start_date).to eq(Date.today)
          end
      
          it 'returns status code 200' do
          expect(response).to have_http_status(:success)
          end
      end 

      context "when the request is invalid" do 
        before do
            put "/api/v1/customers/#{customer.id}", params: {customer: invalid_attributes}
        end
        
        it 'updates the customer' do
            customer.reload 
            expect(customer.first_name).to_not eq(nil)
        end
    
        it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
        end
    end 
    end 
  end
