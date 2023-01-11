class Group < ApplicationRecord
  belongs_to :user

  include Identifiable
  identifiable_by :slug

  validates_presence_of :name
  validates_presence_of :description

  has_many :memberships, dependent: :destroy
  has_many :profiles, through: :memberships
end
