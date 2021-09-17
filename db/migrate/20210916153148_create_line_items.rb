class CreateLineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :line_items do |t|
      t.references :invoice, null:false, foreign_key: true, on_delete: :cascade
      t.string :description, null: false
      t.money :unit_price, default: 0.0
      t.integer :quantity, default: 0
      t.timestamps
    end
  end
end
