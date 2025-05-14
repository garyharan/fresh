class Profile < ApplicationRecord
  belongs_to :user

  has_many :assessments, foreign_key: :from_profile_id, dependent: :destroy
  has_many :partnerships, class_name: "Partnership", foreign_key: :from_profile_id

  has_many :images, dependent: :destroy
  has_many :cards, dependent: :destroy

  delegate :maximum_distance, :maximum_distance=, to: :user, allow_nil: true

  belongs_to :gender, required: false
  has_many :attractions, dependent: :destroy
  has_many :genders, through: :attractions

  has_and_belongs_to_many :rooms
  before_destroy do
    rooms.each { |room| room .destroy }
  end

  include Identifiable
  identifiable_by :public_code

  geocoded_by :location
  after_validation :geocode, if: ->(obj) { obj.location_changed? }

  validates_with ProfileValidator

  scope :of_gender, ->(gender) { where(gender: gender) }

  scope :attracted_to_genders,
        ->(genders) {
          joins(:attractions).where(
            gender_id: [genders.pluck(:id)]
          )
        }

  scope :with_coordinates, -> { self.where.not(latitude: nil, longitude: nil) }

  def self.recommended(profile)
    raise ::ArgumentError, "Profile must be complete" unless profile.complete?

    base_query = where
      .not(
        profiles: {
          id: [
            profile.id,
            profile.assessments.pluck(:to_profile_id)
          ].flatten
        }
      )
      .merge(with_coordinates)
      .merge(attracted_to_genders(profile.genders))
      .merge(
        Profile.joins(:attractions).where(
          attractions: {
            gender: profile.gender
          }
        )
      )

    if profile.only_show_my_relationship_style && profile.relationship_style.present?
      base_query = base_query.where(relationship_style: profile.relationship_style)
    end

    base_query
      .near([profile.latitude, profile.longitude], profile.user.maximum_distance / 10_000)
      .select("
        profiles.*,
        #{profile.height} - height AS height_difference,
        (ABS(('#{profile.born_on}' - born_on) / 365)) AS age_difference
      ").order(:age_difference)
  end

  def complete? # XXX: This is a bit of a hack
    saved_step = step
    step = 4
    complete = valid?
    step = saved_step
    complete
  end

  attr_accessor :step

  def location
    [city, state, country].compact.join(", ")
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
    "Vape only",
    "Prefer not to say"
  ]
  POSSIBLE_DRINKING_OPTIONS = [
    "Never",
    "Occasionally",
    "Often",
    "Prefer not to say"
  ]
end
