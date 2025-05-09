class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show request_more unread ]

  PER_PAGE = 35

  def index
    @rooms = Current.user.profile.rooms
  end

  def show
    @interlocutors = @room.profiles.where.not(id: Current.user.profile.id)
    @messages = @room.messages.order(id: :desc).limit(PER_PAGE).reverse
  end

  def request_more
    @messages = @room.messages.where("id < ?", params[:before].to_i)
                      .order(id: :desc)
                      .includes(:user)
                      .limit(PER_PAGE)
                      .reverse
  end

  private

  def set_room
    @room = Current.user.profile.rooms.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name)
  end
end
