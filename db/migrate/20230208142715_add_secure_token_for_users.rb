class AddSecureTokenForUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :authentication_token, :string
    add_index :users, :authentication_token, unique: true

    User.find_each do |user|
      user.regenerate_authentication_token
    end
  end

  def down
    remove_column :users, :authentication_token
  end
end
