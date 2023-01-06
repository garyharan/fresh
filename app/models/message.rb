class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  has_many :reads, dependent: :destroy
  has_many :users, :through => :reads, :source => :user

  broadcasts_to :room
end
