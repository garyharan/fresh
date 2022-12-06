class Room < ApplicationRecord
  has_and_belongs_to_many :profiles

  has_many :messages, class_name: "Message", dependent: :destroy

  def name
    profiles.map(&:display_name).to_sentence
  end

  def self.find_or_create_by_profiles(profiles)
    room =
      Room
        .includes(:profiles)
        .find { |room| room.profiles.sort == profiles.sort }

    room || Room.create(profiles: profiles)
  end
end
