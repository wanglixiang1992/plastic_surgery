class CreateInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :invoices do |t|
      t.date :invoice_date, null: false
      t.date :due_date
      t.money :amount, default: 0
      t.text :memo
      t.string :qbo_id
      t.string :invoice_number
      t.string :account_number
      t.references :customer, foreign_key: true, on_delete: :cascade
      t.timestamps
    end
  end
end
