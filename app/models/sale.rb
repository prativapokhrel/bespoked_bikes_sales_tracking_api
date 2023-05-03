class Sale < ApplicationRecord
  belongs_to :product
  belongs_to :salesperson
  belongs_to :customer

  validates_presence_of :sales_date
end
