class AddInviteCodeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :invite_code, :string
    add_index :users, :invite_code, unique: true
  end
end
