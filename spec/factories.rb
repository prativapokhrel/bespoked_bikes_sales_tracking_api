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

    # factory :product do
    #     name { Faker::Vehicle.make_and_model }
    #     manufacturer { Faker::Vehicle.manufacture }
    #     style {['Road Bike', 'Mountain Bike', 'City Bike'].sample}
    #     purchase_price {rand(500..1000)}
    #     sale_price {rand(1000..2000)}
    #     qty_on_hand {rand(0..10)}
    #     commission_percentage {rand(5..10)}
    #   end
  end