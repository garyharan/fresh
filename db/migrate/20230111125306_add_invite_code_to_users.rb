class AddInviteCodeToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :invite_code, :string
    add_index :users, :invite_code, unique: true

    User.find_each do |user|
      user.update(invite_code: user.send(:generate_id))
    end
  end

  def down
    remove_column :users, :invite_code
    remove_index :users, :invite_code
  end
end
