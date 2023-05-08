# frozen_string_literal: true

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
    let!(:person2) { FactoryBot.create(:salesperson, phone: '3303303301') }
    let!(:manager) { FactoryBot.create(:manager) }
    let(:valid_attributes) do
      { first_name: 'Ram', last_name: 'Maney', address: '220 south, NY, 44503', phone: '1234567891',
        start_date: Date.today, termination_date: nil, manager_id: manager.id }
    end
    let(:invalid_attributes) do
      { phone: '3303303301', first_name: person2.first_name, last_name: person2.last_name }
    end

    context 'when the request is valid' do
      before do
        put "/api/v1/salespeople/#{person.id}", params: { salesperson: valid_attributes }
      end

      it 'updates the salesperson' do
        person.reload
        expect(person.first_name).to eq('Ram')
        expect(person.last_name).to eq('Maney')
        expect(person.address).to eq('220 south, NY, 44503')
        expect(person.phone).to eq('1234567891')
        expect(person.start_date).to eq(Date.today)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the request is invalid - duplicate phone' do
      before do
        put "/api/v1/salespeople/#{person.id}", params: { salesperson: invalid_attributes }
      end

      it 'does not update the salesperson' do
        person.reload
        expect(person.first_name).to_not eq('New')
        expect(person.last_name).to_not eq('Mew')
        expect(person.phone).to_not eq('3303303301')
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns model error message' do
        expect(json['phone']).to include('has already been taken')
      end
    end
  end

  describe 'GET /quarterly_commission_report' do
    let!(:person) { FactoryBot.create(:salesperson, first_name: 'Mia', last_name: 'Dia') }
    let!(:customer) { FactoryBot.create(:customer) }
    let!(:product) { FactoryBot.create(:product, commission_percentage: 10, sale_price: 1000) }
    let!(:discount) do
      FactoryBot.create(:discount, product_id: product.id, begin_date: 10.days.ago,
                                   end_date: 10.days.from_now, discount_percentage: 10)
    end
    let!(:sale) do
      FactoryBot.create(:sale, salesperson_id: person.id, customer_id: customer.id, product_id: product.id,
                               sales_date: 5.days.ago)
    end

    let!(:person2) { FactoryBot.create(:salesperson, first_name: 'Ram', last_name: 'Sham') }
    let!(:product2) { FactoryBot.create(:product, commission_percentage: 2.5, sale_price: 1300) }

    let!(:discount2) do
      FactoryBot.create(:discount, product_id: product2.id, begin_date: 13.days.ago,
                                   end_date: 10.days.from_now, discount_percentage: 5)
    end
    let!(:discount3) do
      FactoryBot.create(:discount, product_id: product2.id, begin_date: 20.days.ago,
                                   end_date: 2.days.from_now, discount_percentage: 6)
    end
    let!(:discount4) do
      FactoryBot.create(:discount, product_id: product2.id, begin_date: 100.days.ago,
                                   end_date: 20.days.ago, discount_percentage: 7)
    end
    let!(:sale2) do
      FactoryBot.create(:sale, salesperson_id: person2.id, customer_id: customer.id, product_id: product2.id,
                               sales_date: 12.days.ago)
    end
    let!(:sale3) do
      FactoryBot.create(:sale, salesperson_id: person2.id, customer_id: customer.id, product_id: product2.id,
                               sales_date: 2.months.ago)
    end

    before do
      get '/api/v1/quarterly_commission_report?quarter=Q2&year=2023'
    end

    it 'returns all salespeople record' do
      expect(json.size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end

    it 'returns correct data' do
      sp1 = json.first
      sp2 = json.last

      expect(sp1['name']).to eq("#{person.first_name} #{person.last_name}")
      expect(sp1['quarterly_commission']).to eq(90) # 10% of (1000 - 10% of 1000)
      expect(sp1['total_sales']).to eq(900) # 1000 - 10% of 1000

      expect(sp2['name']).to eq("#{person2.first_name} #{person2.last_name}")
      # first_discounted_price = (1300 - 5% of 1300) = 1235
      # second_discounted_price =  first_discounted_price - 6% of first_discounted_price = 1160.9
      # commission = 2.5% of second_discounted_price = 29.0225
      expect(sp2['quarterly_commission']).to eq(29.02)
      expect(sp2['total_sales']).to eq(1160.9)
    end
  end
end
