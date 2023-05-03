# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
I18n.reload!

Product.destroy_all

10.times do |index|
    Product.create!(
      name: Faker::Vehicle.make_and_model,
      manufacturer: Faker::Vehicle.manufacture,
      style: ['Road Bike', 'Mountain Bike', 'City Bike'].sample,
      purchase_price: rand(500..1000),
      sale_price: rand(1000..2000),
      qty_on_hand: rand(0..10),
      commission_percentage: rand(5..10)
    )
  end
  

p "Created #{Product.count} products"
