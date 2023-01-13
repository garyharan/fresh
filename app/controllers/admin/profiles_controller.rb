class Admin::ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!

  def index
    @profiles = Profile.page(params[:page]).per(10)
  end

  private

  def authenticate_admin!
    redirect_to root_path, alert: 'Not authorized.' unless current_user.admin?
  end
end
