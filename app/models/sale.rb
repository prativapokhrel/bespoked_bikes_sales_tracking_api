class Sale < ApplicationRecord
  belongs_to :product
  belongs_to :salesperson
  belongs_to :customer
end
