class PassesController < ApplicationController
  def create
    @profile = Profile.find(params[:profile_id])
    @pass =
      Pass.create! profile_id: params[:profile_id], user_id: Current.user.id
  end

  def destroy
    @profile = Profile.find(params[:profile_id])
    @profile.passes.find_by(user_id: Current.user.id).destroy
  end
end
