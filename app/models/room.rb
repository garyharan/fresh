class Room < ApplicationRecord
  has_and_belongs_to_many :profiles
  accepts_nested_attributes_for :profiles

  has_many :messages, class_name: "Message", dependent: :destroy

  def name
    profiles.map(&:display_name).to_sentence
  end

  def self.find_or_create_by_profiles(profiles)
    Room.find_by_profiles(profiles) || Room.create_with_profiles(profiles)
  end

  def self.find_by_profiles(profiles)
    Room.joins(:profiles).where(profiles: { id: profiles.map(&:id) }).group("rooms.id").having("count(profiles.id) = ?", profiles.size).first
  end

  def self.create_with_profiles(profiles)
    room = Room.create
    room.profiles = profiles
    room.save!
    room
  end
end
