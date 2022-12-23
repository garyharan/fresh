class RecommendationsController < ApplicationController
  before_action :authenticate_user!
  before_action :force_profile_completion, only: %i[index recommended all groups]

  before_action :set_profile, only: %i[like pass]

  def index
    @profile = Profile.recommended(current_user.profile).limit(1).first

    respond_to do |format|
      format.html { render layout: false }
    end
  end

  def like
  end

  def pass
    @pass = Pass.create! profile: @profile, user: current_user
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end
end
