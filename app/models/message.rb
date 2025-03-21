class Message < ApplicationRecord
  include Rails.application.routes.url_helpers

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
      .where(room_id: user.profile.rooms.pluck(:id))
  end

  def self.unread_by_user_in_room(user, room)
    self.joins("LEFT OUTER JOIN reads ON reads.message_id = messages.id AND reads.user_id = #{user.id}")
      .where("reads.id IS NULL")
      .where("messages.user_id != ?", user.id)
      .where(room_id: room.id)
  end

  private

  def notify_recipient
    NotificationChannel.broadcast_to(recipient, { new_message: self.id, room: room.id, sender: user.id, sender_name: user.profile.display_name, body: body, url: room_path(room) })
    UnreadChannel.broadcast_to(recipient, { unread_count: Message.unread_by(recipient).count })

    room.users.each do |user|
      broadcast_replace_to user,
        target: "unread_count_#{room.id}_#{user.id}",
        partial: "shared/unread_messages_with_count",
        locals: { user: user, room: room }
    end
  end

  def recipient
    users.find { |u| u != user }
  end
end
