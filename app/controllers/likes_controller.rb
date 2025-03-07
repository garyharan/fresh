class LikesController < ApplicationController
  def create
    @profile = Profile.find(params[:profile_id])
    @like = Like.create! profile_id: params[:profile_id], user_id: Current.user.id

    if @like.reciprocated?
      redirect_to(Room.find_or_create_by_like(@like))
    else
      redirect_to(profiles_path)
    end
  end

  def destroy
    @profile = Profile.find(params[:profile_id])
    @profile.likes.find_by(user_id: Current.user.id).destroy
  end
end
