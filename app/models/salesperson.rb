class Salesperson < ApplicationRecord
  belongs_to :manager
  has_many :sales 
end
