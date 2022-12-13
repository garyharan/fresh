class Room < ApplicationRecord
  has_and_belongs_to_many :profiles

  has_many :messages, class_name: "Message", dependent: :destroy

  def name
    profiles.map(&:display_name).to_sentence
  end

  def self.find_or_create_by_profiles(profiles)
    # find the room where the profile attached belongs to both profiles
    room = Room.includes(:profiles).where(profiles: { id: profiles.map(&:id) }).first
    room || Room.create(profiles: profiles)
  end
end
