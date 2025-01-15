class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_one :profile, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_many :notification_tokens

  include Identifiable
  identifiable_by :invite_code

  has_many :likes, foreign_key: :user_id, dependent: :destroy
  has_many :passes, foreign_key: :user_id, dependent: :destroy

  def liked_profiles
    Profile.joins(:likes).where(likes: { user_id: id })
  end

  def passed_profiles
    Profile.joins(:passes).where(passes: { user_id: id })
  end
end
