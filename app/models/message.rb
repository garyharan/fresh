class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  has_many :reads, dependent: :destroy
  has_many :users, :through => :reads, :source => :user

  broadcasts_to :room

  def self.unread_by(user)
    self.joins("LEFT OUTER JOIN reads ON reads.message_id = messages.id AND reads.user_id = #{user.id}")
      .where("reads.id IS NULL")
      .where("messages.user_id != ?", user.id)
      .where(rooms: [user.profile.rooms])
  end
end
