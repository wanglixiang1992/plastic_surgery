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

ActiveRecord::Schema.define(version: 2021_09_17_023118) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.string "qbo_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_customers_on_name", unique: true
  end

  create_table "invoices", force: :cascade do |t|
    t.date "invoice_date", null: false
    t.date "due_date"
    t.money "amount", scale: 2, default: "0.0"
    t.text "memo"
    t.string "qbo_id"
    t.string "invoice_number"
    t.string "account_number"
    t.bigint "customer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_invoices_on_customer_id"
  end

  create_table "line_items", force: :cascade do |t|
    t.bigint "invoice_id", null: false
    t.string "description", null: false
    t.money "unit_price", scale: 2, default: "0.0"
    t.integer "quantity", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["description"], name: "index_line_items_on_description", unique: true
    t.index ["invoice_id"], name: "index_line_items_on_invoice_id"
  end

  create_table "quickbooks_credentials", force: :cascade do |t|
    t.text "access_token", null: false
    t.datetime "access_token_expires_at"
    t.text "refresh_token", null: false
    t.datetime "refresh_token_expires_at"
    t.text "realm_id", null: false
    t.boolean "active", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "invoices", "customers"
  add_foreign_key "line_items", "invoices"
end
