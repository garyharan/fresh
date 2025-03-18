class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show unread ]
  layout "chat", only: :show

  PER_PAGE = 10

  def index
    @rooms = Current.user.profile.rooms
  end

  def show
    @interlocutors = @room.profiles.where.not(id: Current.user.profile.id)

    if params[:before].present?
      @messages = @room.messages.where("id < ?", params[:before].to_i).order(:id).last(PER_PAGE)
    else
      @messages = @room.messages.order(:id).last(PER_PAGE)
    end

    respond_to do |format|
      format.html
    end
  end

  private

  def set_room
    @room = Current.user.profile.rooms.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name)
  end
end
