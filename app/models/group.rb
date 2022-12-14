class Group < ApplicationRecord
  belongs_to :user

  self.implicit_order_column = "created_at"

  validates_presence_of :name

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
end
