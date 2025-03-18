class LikesController < ApplicationController
  def create
    @profile = Profile.find(params[:profile_id])
    @profiles = Profile.recommended(Current.user.profile)
    @like = Like.create! profile_id: params[:profile_id], user_id: Current.user.id

    if @like.reciprocated?
      @room = Room.find_or_create_by_like(@like)
      respond_to do |format|
        format.html { redirect_to @room }
        format.turbo_stream { render turbo_stream: turbo_stream.replace('discovery', partial: 'profiles/matched') }
      end
    else
      respond_to do |format|
        format.html { redirect_to profiles_path }
        format.turbo_stream { render turbo_stream: turbo_stream.replace('discovery', partial: 'profiles/index') }
      end
    end
  end

  def destroy
    @profile = Profile.find(params[:profile_id])
    @profile.likes.find_by(user_id: Current.user.id).destroy
  end
end
