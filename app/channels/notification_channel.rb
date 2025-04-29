class NotificationChannel < ApplicationCable::Channel
  def subscribed
     stream_for Current.user
  end
end
