class ImagesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_images
  before_action :set_image, only: [:destroy]

  def index
    @images = current_user.profile.images
  end

  def destroy
    @image = current_user.profile.images.find(params[:id])

    @image.purge

    respond_to { |format| format.json { head :no_content } }
  end

  private

  def set_images
    @images = current_user.profile.images
  end

  def set_image
    @images.find(params[:id])
  end
end
