class Profile < ApplicationRecord
  belongs_to :user

  has_many :likes, foreign_key: :profile_id, dependent: :destroy
  has_many :authored_likes,
           class_name: "Like",
           foreign_key: :author_profile_id,
           dependent: :destroy

  has_many :images, dependent: :destroy
  has_many :cards, dependent: :destroy

  belongs_to :gender, required: false
  has_and_belongs_to_many :genders

  has_and_belongs_to_many :rooms

  geocoded_by :location
  after_validation :geocode, if: ->(obj){ obj.location_changed? }

  validates_with ProfileValidator

  attr_accessor :step

  def location
    [city, state, country].compact.join(', ')
  end

  def location_changed?
    city_changed? || state_changed? || country_changed?
  end

  POSSIBLE_CHILDREN_CONFIGURATIONS = [
    "Want someday",
    "Don't want",
    "Have & want more",
    "Have & don't want more",
    "Not sure yet"
  ]
  POSSIBLE_RELATIONSHIP_STYLES = [
    "Monogamous",
    "Non-monogamous",
    "I would rather not say"
  ]
  POSSIBLE_SMOKING_OPTIONS = [
    "Never",
    "Occasionally",
    "Often",
    "Prefer not to say"
  ]
  POSSIBLE_DRINKING_OPTIONS = [
    "Never",
    "Occasionally",
    "Often",
    "Prefer not to say"
  ]

  def liked_by?(profile)
    likes.where(author_profile: profile).any?
  end
end
