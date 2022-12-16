class OnboardingController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def one
  end

  def two
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
end
