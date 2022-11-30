class LikesController < ApplicationController
  def create
    @profile = Profile.find(params[:profile_id])
    @like =
      Like.create! profile_id: params[:profile_id],
                   author_profile_id: current_user.profile.id
  end

  def destroy
    @profile = Profile.find(params[:profile_id])
    @profile.likes.find_by(author_profile_id: current_user.profile.id).destroy
  end
end
