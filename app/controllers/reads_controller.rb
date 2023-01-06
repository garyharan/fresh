class ReadsController < ApplicationController
  before_action :authenticate_user!

  def create
    Read.create! user: current_user, message_id: params[:message_id]
    head :ok, content_type: "text/html"
  end
end
