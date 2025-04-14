class ProfilesController < ApplicationController
  # before_action :force_profile_completion, only: %i[index]

  before_action :new_profile, only: :new
  before_action :set_profile, only: %i[edit update destroy]

  def index
    @profiles = Profile.recommended(Current.user.profile)
  end

  def passed
    @profiles = Profile.joins(:passes).where(passes: { user_id: Current.user.id }).order("passes.created_at DESC")
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def new
  end

  def edit
  end

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

  def update
    respond_to do |format|
      if update_profile!
        format.turbo_stream do
          flash[:notice] = "Successfully updated."
          refresh_or_redirect_to profiles_path
        end
        format.html do
          flash[:notice] = "Profile was successfully updated."
          recede_or_redirect_to settings_path(@profile)
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

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

  def set_profile
    @profile = Current.user.profile
  end

  def new_profile
    username = Current.user.email_address.split("@")[0]
    @profile = Profile.new display_name: username
  end

  def create_profile!
    @profile = Profile.new(profile_params)
    @profile.user_id = Current.user.id

    @profile.save!
  end

  def update_profile!
    @profile = Current.user.profile

    @profile.update!(profile_params) && @profile.user.save!
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
        :maximum_distance,
        :city,
        :state,
        :country,
        :pot,
        gender_ids: []
      )
    p
  end
end
