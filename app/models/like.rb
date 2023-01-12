class Like < ApplicationRecord
  belongs_to :profile
  belongs_to :user

  before_create do
    Pass.where(user_id: user.id, profile_id: profile.id).destroy_all
  end
end
