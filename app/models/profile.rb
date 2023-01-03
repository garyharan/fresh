class Profile < ApplicationRecord
  belongs_to :user

  has_many :likes, foreign_key: :profile_id, dependent: :destroy
  has_many :passes, foreign_key: :profile_id, dependent: :destroy

  has_many :images, dependent: :destroy
  has_many :cards, dependent: :destroy

  belongs_to :gender, required: false
  has_many :attractions, dependent: :destroy
  has_many :genders, through: :attractions

  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships

  has_and_belongs_to_many :rooms

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

  def self.recommended(profile)
    raise ::ArgumentError, "Profile must be complete" unless profile.complete?

    where
      .not(
        profiles: {
          id: [
            profile.id,
            profile.user.liked_profiles.pluck(:id),
            profile.user.passed_profiles.pluck(:id)
          ].flatten
        }
      )
      .merge(attracted_to_genders(profile.genders))
      .merge(
        Profile.joins(:attractions).where(
          attractions: {
            gender: profile.gender
          }
        )
      )
      .select(
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
        (ABS(('#{profile.born_on}' - born_on) / 365)) AS age_difference
      "
      )
      .order(:age_difference, :distance)
  end

  def self.in_group(group)
    Profile.joins(:memberships).where(memberships: { group_id: group.id })
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

  def liked_by?(model)
    case model
    when User
      likes.where(user: model).any?
    when Profile
      likes.where(user: model.user).any?
    end
  end
end
