class ImagesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_profile
  before_action :set_image, only: %i[show edit update destroy]

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
    @image = Image.new(image_params)
    @image.profile = @profile

    respond_to do |format|
      if @image.save
        format.html do
          redirect_to profile_images_url(@profile),
                      notice: "Image was successfully created."
        end
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json do
          render json: @image.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html do
          redirect_to image_url(@image),
                      notice: "Image was successfully updated."
        end
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json do
          render json: @image.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @image.destroy

    respond_to do |format|
      format.html do
        redirect_to profile_images_path(@profile),
                    notice: "Image was successfully destroyed."
      end
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
    params.require(:image).permit(:photo)
  end

  def sort_params
    params.require(:resource).permit(:id, :position)
  end
end
