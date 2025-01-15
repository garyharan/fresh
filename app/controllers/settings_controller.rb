class SettingsController < ApplicationController
  before_action :set_user
  before_action :set_profile

  layout "settings"

  def index
  end

  def public
  end

  def toggle_public
    @profile.update(public: !@profile.public)
  end

  def invite
  end

  def notifications
  end

  def distance
    @user = Current.user
  end

  def partnerships
    @partnerships = Current.user.profile.partnerships
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
    @user = Current.user
  end

  def set_profile
    @profile = Current.user.profile
  end
end
