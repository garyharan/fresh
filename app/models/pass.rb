class Pass < ApplicationRecord
  belongs_to :profile
  belongs_to :user

  before_create do
    Like.where(user_id: user.id, profile_id: profile.id).destroy_all
  end
end
