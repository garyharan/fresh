class InvitationsController < ApplicationController
  def new
  end

  def save
    session[:invite_code] = params[:invite_code]
    redirect_to new_user_registration_path
  end
end
