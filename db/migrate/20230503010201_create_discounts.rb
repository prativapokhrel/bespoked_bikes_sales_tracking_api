class CreateDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.references :product, null: false, foreign_key: true
      t.date :begin_date
      t.date :end_date
      t.float :discount_percentage

      t.timestamps
    end
  end
end
