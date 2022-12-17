class OnboardingController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def one
  end

  def update_one
    respond_to do |format|
      @profile.attributes = profile_params
      @profile.step = 1
      if @profile.save
        format.html { redirect_to onboarding_two_url }
      else
        format.html { render :one, status: :unprocessable_entity }
      end
    end
  end

  def two
  end

  def update_two
    respond_to do |format|
      @profile.attributes = profile_params
      @profile.step = 2
      if @profile.save
        format.html { redirect_to onboarding_three_url }
      else
        format.html { render :two, status: :unprocessable_entity }
      end
    end
  end

  def three
    @images = @profile.images.order(:position)
  end

  private

  def profile_params
    params.require(:profile).permit(:display_name, :born_on, :lat, :lon, :city, :state, :country, :gender_id, :orientation_id, :show_orientation)
  end

  def set_profile
    @profile = current_user.profile || Profile.create!(user: current_user)
  end

  def profile_params
    params.require(:profile).permit(:display_name, :gender_id, :born_on, :latitude, :longitude, :city, :state, :country)
  end
end
