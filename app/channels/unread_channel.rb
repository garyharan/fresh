class UnreadChannel < ApplicationCable::Channel
  def subscribed
     stream_for Current.user
  end
end
