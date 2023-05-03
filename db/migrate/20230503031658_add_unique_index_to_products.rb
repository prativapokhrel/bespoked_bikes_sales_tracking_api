class AddUniqueIndexToProducts < ActiveRecord::Migration[6.1]
  def change
    add_index :products, [ :name, :manufacturer ], :unique => true 
  end
end
