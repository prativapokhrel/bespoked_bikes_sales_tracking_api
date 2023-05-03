require 'rails_helper'

RSpec.describe 'Products', type: :request do
    describe 'GET /index' do
      before do
        FactoryBot.create_list(:product, 5)
        get '/api/v1/products'
      end
      
      it 'returns all products' do
        expect(json.size).to eq(5)
      end
  
      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end

    describe 'PUT /update' do

        let!(:product) { FactoryBot.create(:product) }
        let!(:product2) { FactoryBot.create(:product, name: "Duplicate name", manufacturer: "Duplicate manufacturer") }
        let(:valid_attributes) {{ name: "BMX Bike", manufacturer: "New manufacturer", style: "New", purchase_price: 100, 
                                    sale_price: 200, qty_on_hand: 2, commission_percentage: 3.5}}
        let(:invalid_attributes) {{name: "Duplicate name", manufacturer: "Duplicate manufacturer"}}

        context "when the request is valid" do 
            before do
                put "/api/v1/products/#{product.id}", params: {product: valid_attributes}
            end
            
            it 'updates the product' do
                product.reload 
                expect(product.name).to eq("BMX Bike")
                expect(product.manufacturer).to eq("New manufacturer")
                expect(product.style).to eq("New")
                expect(product.purchase_price).to eq(100)
                expect(product.sale_price).to eq(200)
                expect(product.qty_on_hand).to eq(2)
                expect(product.commission_percentage).to eq(3.5)
            end
        
            it 'returns status code 200' do
            expect(response).to have_http_status(:success)
            end
        end 

        context "when the request is invalid - duplicate product name and manufacturer" do 
            before do
                put "/api/v1/products/#{product.id}", params: {product: invalid_attributes}
            end
            
            it 'does not update the product' do
                product.reload 
                expect(product.name).to_not eq("Duplicate name")
                expect(product.manufacturer).to_not eq("Duplicate manufacturer")

                expect(product.name).to eq(product.name)
                expect(product.manufacturer).to eq(product.manufacturer)
            end
        
            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns model error message' do
                expect(json["name"]).to include("already exists for this manufacturer")
            end
        end 

    end
  end
