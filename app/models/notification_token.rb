class NotificationToken < ApplicationRecord
  belongs_to :user

  validates :token, presence: true
  validates :platform, inclusion: {in: %w[iOS FCM]}
end
