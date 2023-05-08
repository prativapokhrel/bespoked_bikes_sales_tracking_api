# frozen_string_literal: true

class CreateSales < ActiveRecord::Migration[6.1]
  def change
    create_table :sales do |t|
      t.references :product, null: false, foreign_key: true
      t.references :salesperson, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.date :sales_date

      t.timestamps
    end
  end
end
