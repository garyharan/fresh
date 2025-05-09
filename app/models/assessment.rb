class Assessment < ApplicationRecord
  enum :kind, { liked: 0, passed: 1, unmatched: 2, blocked: 3 }

  belongs_to :from_profile, class_name: 'Profile'
  belongs_to :to_profile, class_name: 'Profile'

  # validates :from_profile_id, uniqueness: { scope: :to_profile_id }
  validate :cannot_assess_self

  def reciprocated?
    return false unless liked?
    Assessment.exists?(from_profile: to_profile, to_profile: from_profile, kind: :liked)
  end

  private

  def cannot_assess_self
    errors.add(:to_profile, "can't be yourself") if from_profile_id == to_profile_id
  end
end
