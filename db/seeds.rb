# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
I18n.reload!

# Product.destroy_all

# 10.times do |index|
#     Product.create!(
#       name: Faker::Vehicle.make_and_model,
#       manufacturer: Faker::Vehicle.manufacture,
#       style: ['Road Bike', 'Mountain Bike', 'City Bike'].sample,
#       purchase_price: rand(500..1000),
#       sale_price: rand(1000..2000),
#       qty_on_hand: rand(0..10),
#       commission_percentage: rand(5..10)
#     )
#   end
  

# p "Created #{Product.count} products"


# # Manager.destroy_all

# 2.times do |index|
#     Manager.create!(
#       first_name: Faker::Name.first_name,
#       last_name: Faker::Name.last_name,
#       email: Faker::Internet.email
#     )
#   end
  

# p "Created #{Manager.count} managers"


# Salesperson.destroy_all

# 5.times do |index|
#     Salesperson.create!(
#       first_name: Faker::Name.first_name,
#       last_name: Faker::Name.last_name,
#       phone: Faker::PhoneNumber.cell_phone,
#       address: Faker::Address.full_address,
#       start_date: Faker::Date.backward(days: 365),
#       termination_date: Faker::Date.forward(days: 365),
#       manager_id: [Manager.first.id, Manager.last.id].sample
#     )
#   end
  
# p "Created #{Salesperson.count} salespeople"


# Customer.destroy_all

# 5.times do |index|
#     Customer.create!(
#       first_name: Faker::Name.first_name,
#       last_name: Faker::Name.last_name,
#       phone: Faker::PhoneNumber.cell_phone,
#       address: Faker::Address.full_address,
#       start_date: Faker::Date.backward(days: 365)
#     )
#   end
  
# p "Created #{Customer.count} customers"

# Customer.destroy_all

# 10.times do |index|
#     Sale.create!(
#       product_id: Product.all.map(&:id).sample,
#       salesperson_id: Salesperson.all.map(&:id).sample,
#       customer_id: Customer.all.map(&:id).sample,
#       sales_date: Faker::Date.backward(days: 365)
#     )
#   end

5.times do |index|
    Discount.create!(
        product_id: Product.all.map(&:id).sample, 
        begin_date: Faker::Date.between(from: 2.days.ago, to: Date.today), 
        end_date:  Faker::Date.between(from: 5.days.from_now, to: 20.days.from_now), 
        discount_percentage: rand(5..10)
    )

end 

p "Created #{Discount.count} discountz"

