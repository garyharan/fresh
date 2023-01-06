class RoomsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_room, only: %i[ show unread ]
  layout "chat", only: :show

  # GET /rooms or /rooms.json
  def index
    @rooms = current_user.profile.rooms
  end

  # GET /rooms/1 or /rooms/1.json
  def show
    @interlocutors = @room.profiles.where.not(id: current_user.profile.id)
    @messages = @room.messages.last(30)
  end

  private

  # limit to only rooms that you are a part of
  def set_room
    @room = current_user.profile.rooms.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def room_params
    params.require(:room).permit(:name)
  end
end
