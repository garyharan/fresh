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

  include Identifiable
  identifiable_by :invite_code

  has_many :managed_groups, class_name: "Group", foreign_key: :user_id
  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships

  has_many :likes, foreign_key: :user_id, dependent: :destroy
  has_many :passes, foreign_key: :user_id, dependent: :destroy

  def liked_profiles
    Profile.joins(:likes).where(likes: { user_id: id })
  end

  def passed_profiles
    Profile.joins(:passes).where(passes: { user_id: id })
  end
end
