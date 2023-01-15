class PublicProfilesController < ApplicationController
  before_action :set_profile

  def show
    if @profile&.public?
      save_public_profile_id!
      render :show
    else
      render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
    end
  end

  private

  def set_profile
    @profile = Profile.find_by(public_code: params[:id])
  end

  def save_public_profile_id!
    session[:public_profile_id] = @profile.id unless user_signed_in?
  end
end
