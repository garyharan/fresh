class MigrateAwayFromDevise < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :password_digest, :string, null: false
    add_index :users, :email_address, unique: true
  end
end
