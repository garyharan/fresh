class RoomsController < ApplicationController
  before_action :authenticate_user!

  layout "chat", only: :show

  # GET /rooms or /rooms.json
  def index
    @rooms = current_user.profile.rooms
  end

  # GET /rooms/1 or /rooms/1.json
  def show
    @room = Room.find(params[:id])
    @interlocutors = @room.profiles.where.not(id: current_user.profile.id)
  end

  def unread
    @room = Room.find(params[:id])
    @messages = @room.messages.where(id: params[:last_message_id].to_i..)

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def room_params
    params.require(:room).permit(:name)
  end
end
