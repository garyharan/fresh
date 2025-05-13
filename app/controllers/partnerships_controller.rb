class PartnershipsController < ApplicationController
  def create
    to_profile = Profile.find(params[:profile_id])

    @partnership = Current.user.profile.partnerships.new(
      from_profile: Current.user.profile,
      to_profile: to_profile,
      status: :unconfirmed
    )

    if @partnership.save
      refresh_or_redirect_to profile_path(to_profile), notice: "Partnership created successfully."
    else
      refresh_or_redirect_to profile_path(to_profile), alert: "Failed to create partnership."
    end
  end

  def destroy
    @partnership = Current.user.profile.partnerships.find_by(to_profile: params[:profile_id])
    to_profile = @partnership.to_profile

    if @partnership.destroy
      refresh_or_redirect_to profile_path(to_profile), notice: "Partnership deleted successfully."
    else
      refresh_or_redirect_to profile_path(to_profile), alert: "Failed to delete partnership."
    end
  end
end
