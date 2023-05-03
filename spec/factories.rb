FactoryBot.define do
    factory :product do
      name { Faker::Vehicle.make_and_model }
      manufacturer { Faker::Vehicle.manufacture }
      style {['Road Bike', 'Mountain Bike', 'City Bike'].sample}
      purchase_price {rand(500..1000)}
      sale_price {rand(1000..2000)}
      qty_on_hand {rand(0..10)}
      commission_percentage {rand(5..10)}
    end

    factory :manager do 
        first_name { Faker::Name.first_name }
        last_name { Faker::Name.last_name }
        email { Faker::Internet.email }
    end 

    factory :salesperson do
        association :manager 
        first_name { Faker::Name.first_name }
        last_name { Faker::Name.last_name }
        phone {Faker::PhoneNumber.cell_phone}
        address { Faker::Address.full_address }
        start_date { Faker::Date.backward(days: 365) }
        termination_date { Faker::Date.forward(days: 365) }
        manager_id {[Manager.first.id, Manager.last.id].sample}
    end
  end