class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room

  def create
    @message = Message.create! message_params.merge(user: current_user, room: @room)
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def set_room
    @room = Room.find(params[:room_id])
  end
end
