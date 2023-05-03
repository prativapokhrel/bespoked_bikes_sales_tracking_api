class CreateSalespeople < ActiveRecord::Migration[6.1]
  def change
    create_table :salespeople do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :phone
      t.date :start_date
      t.date :termination_date
      t.references :manager, null: false, foreign_key: true

      t.timestamps
    end
  end
end
