class Admin::ProfilesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @profiles = Profile.order(created_at: :desc).page(params[:page]).per(10)
  end

  private

  def authenticate_admin!
    redirect_to root_path, alert: 'Not authorized.' unless Current.user.admin?
  end
end
