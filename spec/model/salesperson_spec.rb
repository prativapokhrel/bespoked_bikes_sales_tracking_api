require 'rails_helper'

RSpec.describe Salesperson, type: :model do
  context 'validations' do
    let!(:person) { FactoryBot.create(:salesperson) }

    it 'is valid with valid attributes' do
      expect(person).to be_valid
    end

    it 'is not valid without a first name' do
        person.first_name = nil
        expect(person).to_not be_valid
    end

    it 'is not valid without a last name' do
        person.last_name = nil
        expect(person).to_not be_valid
    end

    it 'is not valid without a phone' do
        person.phone = nil
        expect(person).to_not be_valid
    end

    it 'is not valid without a start date' do
        person.start_date = nil
        expect(person).to_not be_valid
    end

    it 'is not valid without a manager' do
        person.manager = nil
        expect(person).to_not be_valid
    end

    it 'is not valid with a duplicate phone' do
      existing_person = FactoryBot.create(:salesperson)
      person.phone = existing_person.phone
      expect(person).to_not be_valid
      expect(person.errors.full_messages).to include("Phone has already been taken")
    end
  end
end