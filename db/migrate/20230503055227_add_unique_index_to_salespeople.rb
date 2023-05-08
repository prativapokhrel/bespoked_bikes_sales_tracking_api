# frozen_string_literal: true

class AddUniqueIndexToSalespeople < ActiveRecord::Migration[6.1]
  def change
    add_index :salespeople, :phone, unique: true
  end
end
