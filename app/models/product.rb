class Product < ApplicationRecord
    has_many :sales 
    has_many :discounts 

    validates_uniqueness_of :name, scope: :manufacturer, 
                            message: "already exists for this manufacturer"
    
    validates_presence_of :name, :manufacturer, :purchase_price, :sale_price

   
    
    
end
