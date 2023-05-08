# frozen_string_literal: true

class AddUniqueIndexToProducts < ActiveRecord::Migration[6.1]
  def change
    add_index :products, %i[name manufacturer], unique: true
  end
end
