class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :qbo_id
      t.timestamps
    end
  end
end
