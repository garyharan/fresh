class AddInviteeColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :inviter_id, :integer, foreign_key: true, class_name: 'User'
  end
end
