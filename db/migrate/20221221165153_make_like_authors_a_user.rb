class MakeLikeAuthorsAUser < ActiveRecord::Migration[7.0]
  def up
    add_column :likes, :user_id, :bigint

    Like.all.each do |like|
      like.user = like.author_profile.user
      like.save
    end

    remove_column :likes, :author_profile_id
  end

  def down
    add_column :likes, :author_profile_id, :bigint

    Like.all.each do |like|
      like.author_profile = like.user.profile
      like.save
    end

    remove_column :likes, :user_id
  end
end
