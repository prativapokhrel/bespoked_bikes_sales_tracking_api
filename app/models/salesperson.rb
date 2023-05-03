class Salesperson < ApplicationRecord
  belongs_to :manager
  has_many :sales 

  validates_uniqueness_of :phone
end
