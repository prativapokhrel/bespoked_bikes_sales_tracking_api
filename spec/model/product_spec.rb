require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'validations' do
    let!(:product) { FactoryBot.create(:product) }

    it 'is valid with valid attributes' do
      expect(product).to be_valid
    end

    it 'is not valid without a name' do
      product.name = nil
      expect(product).to_not be_valid
    end

    it 'is not valid without a manufacturer' do
      product.manufacturer = nil
      expect(product).to_not be_valid
    end

    it 'is not valid without a purchase_price' do
        product.purchase_price = nil
        expect(product).to_not be_valid
    end

    it 'is not valid without a sale_price' do
        product.sale_price = nil
        expect(product).to_not be_valid
    end

    it 'is not valid with a duplicate name and manufacturer combination' do
      existing_product = FactoryBot.create(:product)
      product.name = existing_product.name
      product.manufacturer = existing_product.manufacturer
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Name already exists for this manufacturer")
    end
  end
end