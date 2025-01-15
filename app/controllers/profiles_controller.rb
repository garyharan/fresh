class ProfilesController < ApplicationController
  before_action :force_profile_completion, only: %i[index]

  before_action :new_profile, only: :new
  before_action :set_profile, only: %i[edit update destroy]

  # GET /profiles or /profiles.json
  def index
    respond_to do |format|
      format.html { render layout: "application" }
    end
  end

  def passed
    @profiles = Profile.joins(:passes).where(passes: { user_id: Current.user.id }).order("passes.created_at DESC")
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
      if update_profile!
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
    @profile = Current.user.profile
  end

  def new_profile
    username = Current.user.email.split("@")[0]
    @profile = Profile.new display_name: username
  end

  def create_profile!
    @profile = Profile.new(profile_params)
    @profile.user_id = Current.user.id

    @profile.save!
  end

  def update_profile!
    @profile = Current.user.profile

    @profile.update(profile_params)
  end

  def profile_params
    p =
      params.require(:profile).permit(
        :display_name,
        :gender_id,
        :relationship_style,
        :show_orientation,
        :born_on,
        :height,
        :drinking,
        :smoking,
        :children,
        :city,
        :state,
        :country,
        :pot,
        gender_ids: []
      )
    p
  end
end
