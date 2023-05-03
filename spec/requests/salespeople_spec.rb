require 'rails_helper'

RSpec.describe 'Salespeople', type: :request do
    describe 'GET /index' do
      before do
        FactoryBot.create_list(:salesperson, 3)
        get '/api/v1/salespeople'
      end
      
      it 'returns all salespeople' do
        expect(json.size).to eq(3)
      end
  
      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end

    describe 'PUT /update' do

        let!(:person) { FactoryBot.create(:salesperson) }
        let!(:person2) { FactoryBot.create(:salesperson, phone: "3303303301") }
        let!(:manager) {FactoryBot.create(:manager)}
        let(:valid_attributes) {{ first_name: "Ram", last_name: "Maney", address: "220 south, NY, 44503", phone: "1234567891", 
                                    start_date: Date.today, termination_date: nil, manager_id: manager.id }}
        let(:invalid_attributes) {{phone: "3303303301", first_name: person2.first_name, last_name: person2.last_name}}

        context "when the request is valid" do 
            before do
                put "/api/v1/salespeople/#{person.id}", params: {salesperson: valid_attributes}
            end
            
            it 'updates the salesperson' do
                person.reload 
                expect(person.first_name).to eq("Ram")
                expect(person.last_name).to eq("Maney")
                expect(person.address).to eq("220 south, NY, 44503")
                expect(person.phone).to eq("1234567891")
                expect(person.start_date).to eq(Date.today)
            end
        
            it 'returns status code 200' do
            expect(response).to have_http_status(:success)
            end
        end 

        context "when the request is invalid - duplicate phone" do 
            before do
                put "/api/v1/salespeople/#{person.id}", params: {salesperson: invalid_attributes}
            end
            
            it 'does not update the salesperson' do
                person.reload 
                expect(person.first_name).to_not eq("New")
                expect(person.last_name).to_not eq("Mew")
                expect(person.phone).to_not eq("3303303301")
            end
        
            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns model error message' do
                expect(json["phone"]).to include("has already been taken")
            end
        end 

    end
  end
