# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :manufacturer
      t.string :style
      t.float :purchase_price
      t.float :sale_price
      t.integer :qty_on_hand
      t.float :commission_percentage

      t.timestamps
    end
  end
end
