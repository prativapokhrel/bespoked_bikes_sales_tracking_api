class AddNotNullConstraintsToColumns < ActiveRecord::Migration[6.1]
  def change
    change_column_null :products, :name, false
    change_column_null :products, :manufacturer, false
    change_column_null :products, :purchase_price, false
    change_column_null :products, :sale_price, false

    change_column_null :sales, :sales_date, false

    change_column_null :salespeople, :first_name, false
    change_column_null :salespeople, :last_name, false
    change_column_null :salespeople, :phone, false
    change_column_null :salespeople, :termination_date, false

    change_column_null :customers, :first_name, false
    change_column_null :customers, :last_name, false
    change_column_null :customers, :start_date, false
  end
end
