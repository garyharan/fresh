class Like < ApplicationRecord
  belongs_to :profile
  belongs_to :user

  before_create do
    Pass.where(user_id: user.id, profile_id: profile.id).destroy_all
  end

  after_create :create_room_if_reciprocated

  def reciprocated?
    Like.exists?(user_id: profile.user_id, profile_id: user.profile.id)
  end

  private

  def create_room_if_reciprocated
    return unless reciprocated?

    Room.find_or_create_by_like(self)
  end
end
