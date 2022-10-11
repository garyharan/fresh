class ProfilesController < ApplicationController
  before_action :authenticate_user!

  before_action :new_profile, only: :new
  before_action :set_profile, only: %i[edit update destroy]

  # GET /profiles or /profiles.json
  def index
    redirect_to new_profile_url if current_user.profile.blank?
    @profiles = Profile.all
  end

  # GET /profiles/1 or /profiles/1.json
  def show
    @profile = Profile.find(params[:id])
  end

  # GET /profiles/new
  def new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles or /profiles.json
  def create
    respond_to do |format|
      if create_profile!
        format.html do
          redirect_to profile_url(@profile),
                      notice: "Profile was successfully created."
        end
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json do
          render json: @profile.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /profiles/1 or /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html do
          redirect_to profile_url(@profile),
                      notice: "Profile was successfully updated."
        end
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json do
          render json: @profile.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /profiles/1 or /profiles/1.json
  def destroy
    @profile.destroy

    respond_to do |format|
      format.html do
        redirect_to profiles_url, notice: "Profile was successfully destroyed."
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @profile = current_user.profile
  end

  def new_profile
    username = current_user.email.split("@")[0]
    @profile = Profile.new display_name: username
  end

  def create_profile!
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id

    images = params.dig(:profile, :images) || []

    @profile.save! && images.all? { |image| @profile.images.attach(image) }
  end

  # Only allow a list of trusted parameters through.
  def profile_params
    params.require(:profile).permit(:body, :born)
  end
end
