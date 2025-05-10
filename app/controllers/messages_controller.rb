class MessagesController < ApplicationController
  def create
    if @room = Room.find_by(id: params[:room_id])
      @message = Message.create! message_params.merge(user: Current.user, room: @room)

      respond_to do |format|
        format.turbo_stream
        format.json { render json: @message, status: :created }
      end
    else
      flash.notice = "This room is no longer available."
      recede_or_redirect_to rooms_url
    end

  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
