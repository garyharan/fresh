class ImagesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_images
  before_action :set_image, only: [:destroy]
  before_action :set_profile

  def index
    @images = current_user.profile.images
  end

  def destroy
    @image = current_user.profile.images.find(params[:id])

    @image.purge

    @images = current_user.profile.images

    respond_to { |format| format.turbo_stream if @image.purge }
  end

  private

  def set_images
    @images = current_user.profile.images
  end

  def set_image
    @images.find(params[:id])
  end

  def set_profile
    @profile = Profile.where(user_id: current_user.id).first
  end
end
