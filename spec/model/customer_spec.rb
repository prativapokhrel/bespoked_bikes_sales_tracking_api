# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer, type: :model do
  context 'validations' do
    let!(:customer) { FactoryBot.create(:customer) }

    it 'is valid with valid attributes' do
      expect(customer).to be_valid
    end

    it 'is not valid without a first name' do
      customer.first_name = nil
      expect(customer).to_not be_valid
    end

    it 'is not valid without a last name' do
      customer.last_name = nil
      expect(customer).to_not be_valid
    end

    it 'is not valid without a start date' do
      customer.start_date = nil
      expect(customer).to_not be_valid
    end
  end
end
