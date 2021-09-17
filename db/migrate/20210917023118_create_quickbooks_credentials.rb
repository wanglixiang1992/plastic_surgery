class CreateQuickbooksCredentials < ActiveRecord::Migration[6.1]
  def change
    create_table :quickbooks_credentials do |t|
      t.text :access_token, null: false
      t.datetime :access_token_expires_at
      t.text :refresh_token, null: false
      t.datetime :refresh_token_expires_at
      t.text :realm_id, null: false
      t.boolean :active, default: :false
      t.timestamps
    end
  end
end
