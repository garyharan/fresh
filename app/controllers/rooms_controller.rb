class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show request_more unread ]

  PER_PAGE = 10

  def index
    @rooms = Current.user.profile.rooms
  end

  def show
    @interlocutors = @room.profiles.where.not(id: Current.user.profile.id)
    @messages = @room.messages.order(:id).last(PER_PAGE)

    respond_to do |format|
      format.html
    end
  end

  def request_more
    @messages = @room.messages.where("id < ?", params[:before].to_i).order(:id).includes(:user).last(PER_PAGE)
  end

  private

  def set_room
    @room = Current.user.profile.rooms.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name)
  end
end
