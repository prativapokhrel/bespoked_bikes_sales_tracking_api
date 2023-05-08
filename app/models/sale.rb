# frozen_string_literal: true

class Sale < ApplicationRecord

  #associations
  belongs_to :product
  belongs_to :salesperson
  belongs_to :customer

  #validations
  validates_presence_of :sales_date

  #scopes
  default_scope { order(created_at: :desc) }

  # returns commission of sales persoon
  def salesperson_commission
    commission_percentage = product.commission_percentage
    commission = discounted_price * commission_percentage / 100
    commission.round(2)
  end

  # returns the salesprice after applying discount
  def discounted_price
    discounts = product.discounts.where('begin_date <= ? AND end_date >= ?', sales_date.beginning_of_day,
                                        sales_date.end_of_day)
    discounted_price = product.sale_price

    discounts&.each do |discount|
      discounted_price -= discounted_price * (discount.discount_percentage / 100)
    end
    discounted_price.round(2)
  end
end
