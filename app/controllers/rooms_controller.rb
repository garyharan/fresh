class RoomsController < ApplicationController
  before_action :authenticate_user!

  layout "chat"

  # GET /rooms or /rooms.json
  def index
    @rooms = current_user.profile.rooms
  end

  # GET /rooms/1 or /rooms/1.json
  def show
    @room = Room.find(params[:id])
  end

  private

  # Only allow a list of trusted parameters through.
  def room_params
    params.require(:room).permit(:name)
  end
end
