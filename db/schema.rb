# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_230_503_170_410) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'customers', force: :cascade do |t|
    t.string 'first_name', null: false
    t.string 'last_name', null: false
    t.string 'address'
    t.string 'phone'
    t.date 'start_date', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'discounts', force: :cascade do |t|
    t.bigint 'product_id', null: false
    t.date 'begin_date'
    t.date 'end_date'
    t.float 'discount_percentage'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['product_id'], name: 'index_discounts_on_product_id'
  end

  create_table 'managers', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.string 'email'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'products', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'manufacturer', null: false
    t.string 'style'
    t.float 'purchase_price', null: false
    t.float 'sale_price', null: false
    t.integer 'qty_on_hand'
    t.float 'commission_percentage'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[name manufacturer], name: 'index_products_on_name_and_manufacturer', unique: true
  end

  create_table 'sales', force: :cascade do |t|
    t.bigint 'product_id', null: false
    t.bigint 'salesperson_id', null: false
    t.bigint 'customer_id', null: false
    t.date 'sales_date', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['customer_id'], name: 'index_sales_on_customer_id'
    t.index ['product_id'], name: 'index_sales_on_product_id'
    t.index ['salesperson_id'], name: 'index_sales_on_salesperson_id'
  end

  create_table 'salespeople', force: :cascade do |t|
    t.string 'first_name', null: false
    t.string 'last_name', null: false
    t.string 'address'
    t.string 'phone', null: false
    t.date 'start_date', null: false
    t.date 'termination_date'
    t.bigint 'manager_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['manager_id'], name: 'index_salespeople_on_manager_id'
    t.index ['phone'], name: 'index_salespeople_on_phone', unique: true
  end

  add_foreign_key 'discounts', 'products'
  add_foreign_key 'sales', 'customers'
  add_foreign_key 'sales', 'products'
  add_foreign_key 'sales', 'salespeople'
  add_foreign_key 'salespeople', 'managers'
end
