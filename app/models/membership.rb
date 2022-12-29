class Membership < ApplicationRecord
  belongs_to :profile
  has_one :user, through: :profile

  belongs_to :group
end
