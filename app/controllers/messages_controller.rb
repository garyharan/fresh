class MessagesController < ApplicationController
  before_action :set_room

  def create
    @message = Message.create! message_params.merge(user: Current.user, room: @room)

    respond_to do |format|
      format.turbo_stream
      format.json { render json: @message, status: :created }
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def set_room
    @room = Room.find(params[:room_id])
  end
end
