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
  has_many :attractions, dependent: :destroy
  has_many :genders, through: :attractions
  accepts_nested_attributes_for :attractions, allow_destroy: true

  has_and_belongs_to_many :rooms

  geocoded_by :location
  after_validation :geocode, if: ->(obj) { obj.location_changed? }

  validates_with ProfileValidator

  scope :of_gender, ->(gender) { where(gender: gender) }

  scope :attracted_to_gender,
        ->(gender) {
          where.not(display_name: nil) # just to pass through
        }

  def self.recommended(profile)
    raise ::ArgumentError, "Profile must be complete" unless profile.complete?

    where.not(profiles: { id: profile.id })
    .where(gender_id: profile.attractions.map { |a| a.gender_id }.to_a )
    .merge(
      Profile.joins(:attractions).where(
        attractions: { gender_id: profile.gender_id }
      )
    ).select(
      "
        profiles.*, (
          6371.0 * 2 * asin(
            sqrt(
              power(
                sin(
                  (#{profile.latitude} - profiles.latitude) * pi() / 180 / 2
                ),
                2
              ) + cos(
                #{profile.latitude} * pi() / 180
              ) * cos(
                profiles.latitude * pi() / 180
              ) * power(
                sin((#{profile.longitude} - profiles.longitude) * pi() / 180 / 2), 2
              )
            )
          )
        ) AS distance,
        #{profile.height} - height AS height_difference,
        (('#{profile.born_on}' - born_on) / 365) AS age_difference
      "
    ).order(:age_difference, :distance)
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
