class Read < ApplicationRecord
  belongs_to :user
  has_one :profile, through: :reader

  belongs_to :message
end
