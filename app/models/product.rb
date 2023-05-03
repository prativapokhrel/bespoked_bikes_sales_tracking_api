class Product < ApplicationRecord
    has_many :sales 
    has_many :discounts 

    validates_uniqueness_of :name, scope: :manufacturer, message: "name already exists for this manufacturer"
end
