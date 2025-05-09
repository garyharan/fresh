class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  has_one :profile, dependent: :destroy

  has_many :notification_tokens

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  include Identifiable
  identifiable_by :invite_code

  has_many :likes, foreign_key: :user_id, dependent: :destroy
  has_many :passes, foreign_key: :user_id, dependent: :destroy

  def liked_profiles
    profile.assessments.where(kind: :liked).map(&:to_profile)
  end

  def passed_profiles
    profile.assessments.where(kind: :passed).map(&:to_profile)
  end
end
