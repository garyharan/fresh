class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  has_one :profile, dependent: :destroy

  has_many :notification_tokens, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :reads, dependent: :destroy

  has_many :events, foreign_key: :creator_id, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  include Identifiable
  identifiable_by :invite_code

  def liked_profiles
    profile.assessments.where(kind: :liked).map(&:to_profile)
  end

  def passed_profiles
    profile.assessments.where(kind: :passed).map(&:to_profile)
  end
end
