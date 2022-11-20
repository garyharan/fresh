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

  POSSIBLE_DISTANCES = [5, 10, 25, 50, 100, 250, Float::INFINITY]
  POSSIBLE_FRESHNESS = [7, 14, 30, 60, 90, Float::INFINITY]
end
