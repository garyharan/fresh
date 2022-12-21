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
  has_many :attractions
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

    self.find_by_sql(
      [
        "
          SELECT profiles.*, (
            6371.0 * 2 * asin(sqrt(power(sin((? - profiles.latitude) * pi() / 180 / 2), 2) + cos(? * pi() / 180) * cos(profiles.latitude * pi() / 180) * power(sin((? - profiles.longitude) * pi() / 180 / 2), 2)))
          ) AS distance,
          ? - height AS height_difference,
          ((? - born_on) / 365) AS age_difference
          FROM
            profiles
          INNER JOIN attractions
          ON attractions.profile_id = profiles.id
          WHERE attractions.gender_id = ?
          AND profiles.id != ?
          ORDER BY age_difference, distance, distance ASC
        ",
        profile.latitude,
        profile.latitude,
        profile.longitude,
        profile.height,
        profile.born_on,
        profile.gender.id,
        profile.id
      ]
    )
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
