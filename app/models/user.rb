class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :trackable,
         :confirmable,
         :lockable

  has_one :profile, dependent: :destroy

  has_secure_token :authentication_token

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

  def self.valid_credentials?(email, password)
    user = User.find_for_authentication(:email => email)
    user&.valid_password?(password) ? user : nil
  end
end
