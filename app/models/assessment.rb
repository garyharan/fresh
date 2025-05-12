class Assessment < ApplicationRecord
  enum :kind, { liked: 0, passed: 1, unmatched: 2, blocked: 3 }

  belongs_to :from_profile, class_name: 'Profile'
  belongs_to :to_profile, class_name: 'Profile'

  def reciprocated?
    return false unless liked?
    Assessment.exists?(from_profile: to_profile, to_profile: from_profile, kind: :liked)
  end
end
