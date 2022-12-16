class ImagesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_profile
  before_action :set_image, only: %i[show edit destroy]

  def index
    @images = @profile.images.order(:position)
    @image = Image.new
  end

  def show
  end

  def new
    @image = Image.new
  end

  def edit
  end

  def sort
    image = @profile.images.find(sort_params[:id])
    image.insert_at(sort_params[:position].to_i)
    head :ok
  end

  def create
    images =
      if params[:image]["photo"].is_a?(Array)
        params["image"]["photo"].reject(&:blank?)
      else
        [params["image"]["photo"]]
      end

    @images =
      images.map do |photo|
        image = Image.new(profile: @profile)
        image.photo.attach(photo)
        image.save!
        image
      end

    respond_to do |format|
      if @images.all?(&:valid?)
        format.turbo_stream do
          @images = @profile.images.order(:position)
        end
        format.html { redirect_to profile_images_url(@profile) }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json do
          render json: @images.first { |i| i.errors.any? }.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @image.destroy

    respond_to do |format|
      format.turbo_stream { @images = @profile.images.order(:position) }
      format.html { redirect_to profile_images_path(@profile) }
      format.json { head :no_content }
    end
  end

  private

  def set_profile
    @profile = current_user.profile
  end

  def set_image
    @image = Image.find(params[:id])
  end

  def image_params
    params.require(:image).require(:photo)
    params.require(:image).permit(:photo)
  end

  def sort_params
    params.require(:resource).permit(:id, :position)
  end
end
