class Like < ApplicationRecord
  belongs_to :profile
  belongs_to :author_profile, class_name: "Profile"

  after_create :create_room_if_recriprocal

  private

  def create_room_if_recriprocal
    if profile.liked_by?(author_profile)
      Room.find_or_create_by_profiles([profile, author_profile])
    end
  end
end
