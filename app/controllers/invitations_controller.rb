class InvitationsController < ApplicationController
  allow_unauthenticated_access

  def new
  end

  def save
    session[:invite_code] = params[:invite_code]
    redirect_to new_user_path
  end
end
