class Product < ApplicationRecord
    has_many :sales 
    has_many :discounts 
end
