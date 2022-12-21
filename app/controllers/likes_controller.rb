class LikesController < ApplicationController
  def create
    @profile = Profile.find(params[:profile_id])
    @like =
      Like.create! profile_id: params[:profile_id],
                   user_id: current_user.id
  end

  def destroy
    @profile = Profile.find(params[:profile_id])
    @profile.likes.find_by(user_id: current_user.id).destroy
  end
end
