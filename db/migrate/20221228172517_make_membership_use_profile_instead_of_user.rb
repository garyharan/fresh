class MakeMembershipUseProfileInsteadOfUser < ActiveRecord::Migration[7.0]
  def up
    add_column :memberships, :profile_id, :bigint
    add_index :memberships, :profile_id

    Membership.all.each do |membership|
      membership.profile = membership.user.profile
      membership.save!
    end

    remove_column :memberships, :user_id
  end

  def down
    add_column :memberships, :user_id, :bigint
    add_index :memberships, :user_id

    Membership.all.each do |membership|
      membership.user = membership.profile.user
      membership.save!
    end

    remove_column :memberships, :profile_id
  end
end
