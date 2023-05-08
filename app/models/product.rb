# frozen_string_literal: true

class Product < ApplicationRecord

  #associations
  has_many :sales
  has_many :discounts

  #validations
  validates_uniqueness_of :name, scope: :manufacturer,
                                 message: 'already exists for this manufacturer'

  validates_presence_of :name, :manufacturer, :purchase_price, :sale_price

  #scopes
  default_scope { order(created_at: :desc) }
end
