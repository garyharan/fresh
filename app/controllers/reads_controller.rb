class ReadsController < ApplicationController
  def create
    Read.create! user: Current.user, message_id: params[:message_id]
    head :ok, content_type: "text/html"
  end
end
