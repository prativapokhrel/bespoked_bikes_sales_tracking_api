class Sale < ApplicationRecord
  belongs_to :product
  belongs_to :salesperson
  belongs_to :customer

  validates_presence_of :sales_date

  def salesperson_commission
    sale_price = product.sale_price
            
    commission_percentage = product.commission_percentage

    commission = discounted_price * commission_percentage / 100
    commission

  end 

  def discounted_price

    discounts = product.discounts.where("begin_date <= ? AND end_date >= ?", sales_date.beginning_of_day, sales_date.end_of_day)
    discounted_price = product.sale_price 

    discounts && discounts.each do |discount|
      discounted_price -= discounted_price * (discount.discount_percentage / 100)
    end 
    discounted_price
  end
end
