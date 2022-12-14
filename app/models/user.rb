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

  has_many :managed_groups, class_name: "Group", foreign_key: :user_id
  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships
end
