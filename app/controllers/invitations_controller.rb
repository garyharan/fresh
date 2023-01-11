class InvitationsController < ApplicationController
  def save
    session[:inviter_id] = params[:user_id]
    redirect_to new_user_registration_path
  end
end
