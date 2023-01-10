class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  has_many :reads, dependent: :destroy
  has_many :profiles, through: :room
  has_many :users, through: :profiles

  has_many :readers, through: :reads, source: :user

  after_create :notify_recipient

  broadcasts_to :room

  def self.unread_by(user)
    self.joins("LEFT OUTER JOIN reads ON reads.message_id = messages.id AND reads.user_id = #{user.id}")
      .where("reads.id IS NULL")
      .where("messages.user_id != ?", user.id)
      .where(rooms: [user.profile.rooms])
  end

  private

  def notify_recipient
    UnreadChannel.broadcast_to(recipient, { unread_count: Message.unread_by(recipient).count })
  end

  def recipient
    users.find { |u| u != user }
  end
end
