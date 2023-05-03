require 'rails_helper'

RSpec.describe Discount, type: :model do
  context 'validations' do
    let!(:discount) { FactoryBot.create(:discount) }

    it 'is valid with valid attributes' do
      expect(discount).to be_valid
    end

    it 'is not valid without a product_id' do
      discount.product_id = nil
      expect(discount).to_not be_valid
    end
  end

  context 'associations' do 
    let!(:product) {FactoryBot.create(:product)}
    let!(:discount) { FactoryBot.create(:discount, product_id: product.id) }

    it 'associates discount with product' do
        expect(product.reload.discounts).to eq([discount]) 
      end
  end 
end