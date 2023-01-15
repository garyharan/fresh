class PublicProfilesController < ApplicationController
  before_action :set_profile

  def show
    if @profile&.public?
      render :show
    else
      render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
    end
  end

  private

  def set_profile
    @profile = Profile.find_by(public_code: params[:id])
  end
end
