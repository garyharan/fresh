class SettingsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_user
  before_action :set_profile

  def index
  end

  def public
  end

  def invite
  end

  def update
    if params[:user].present?
      update_user!
    end
  end

  private

  def update_user!
    @user.update(update_user_params)
  end

  def update_user_params
    params.require(:user).permit(:distance)
  end

  def set_user
    @user = current_user
  end

  def set_profile
    @profile = current_user.profile
  end
end
