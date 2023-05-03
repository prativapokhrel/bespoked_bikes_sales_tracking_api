require 'rails_helper'

RSpec.describe 'Sales', type: :request do
    describe 'GET /index' do

      context "without date filter" do 
        before do
            FactoryBot.create_list(:sale, 3)
            get '/api/v1/sales'
          end
          
          it 'returns all sales' do
            expect(json.size).to eq(3)
          end
      
          it 'returns status code 200' do
            expect(response).to have_http_status(:success)
          end
      end 
    
     
      context "with date filter params" do 

        let!(:sale) {FactoryBot.create(:sale, sales_date: 2.days.ago)}
        let!(:sale2) {FactoryBot.create(:sale, sales_date: 30.days.ago)}
        let!(:sale3) {FactoryBot.create(:sale, sales_date: Date.today)}

        before do
            get "/api/v1/sales?from_date=#{20.days.ago}&to_date=#{Date.today}"
          end
          
          it 'returns filtered sales' do
            expect(json.size).to eq(2)
          end
      
          it 'returns status code 200' do
            expect(response).to have_http_status(:success)
          end

          it 'returns sale and sale3 data only' do 
            expect(json.first["id"]).to eq(sale.id)
            expect(json.last["id"]).to eq(sale3.id)
            expect(json.map{|sl| sl["id"] }).to_not eq(sale2.id)
          end 
      end 
    
    end

    describe 'POST /create' do

        let!(:customer) {FactoryBot.create(:customer)}
        let!(:salesperson) {FactoryBot.create(:salesperson)}
        let!(:product) {FactoryBot.create(:product)}

        let(:valid_attributes) {{  customer_id: customer.id, salesperson_id: salesperson.id, product_id: product.id, 
                                   sales_date: Date.today - 2 }}
        let(:invalid_attributes) {{ customer: nil, salesperson: nil, product: nil, sales_date: Date.today - 2 }}

        context "when the request is valid" do 
            before do
                post "/api/v1/sales", params: {sale: valid_attributes}
            end
            
            it 'returns the customer_id' do
                expect(json['customer_id']).to eq(customer.id)
              end
        
            it 'returns the salesperson_id' do
                expect(json['salesperson_id']).to eq(salesperson.id)
            end

            it 'returns the product_id' do
                expect(json['product_id']).to eq(product.id)
            end
    
            it 'returns a created status' do
                expect(response).to have_http_status(:created)
            end
        end 

        context "when the request is invalid - duplicate phone" do 
            before do
                post "/api/v1/sales", params: {sale: invalid_attributes}

            end

            it 'returns unprocessable entity status' do
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end 
    end
  end
