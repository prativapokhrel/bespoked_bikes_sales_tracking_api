require 'rails_helper'

RSpec.describe Sale, type: :model do
  context 'validations' do
    let!(:sale) { FactoryBot.create(:sale) }

    it 'is valid with valid attributes' do
      expect(sale).to be_valid
    end

    it 'is not valid without a customer_id' do
        sale.customer_id = nil
        expect(sale).to_not be_valid
    end

    it 'is not valid without a salesperson_id' do
        sale.salesperson_id = nil
        expect(sale).to_not be_valid
    end

    it 'is not valid without a product_id' do
        sale.product_id = nil
        expect(sale).to_not be_valid
    end

    it 'is not valid without a start date' do
        sale.sales_date = nil
        expect(sale).to_not be_valid
    end
  end
end