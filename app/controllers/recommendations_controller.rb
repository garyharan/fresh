class RecommendationsController < ApplicationController
  before_action :authenticate_user!
  before_action :force_profile_completion

  before_action :set_group
  before_action :set_profile, only: %i[like pass]

  def index
    @profile = @group.present? ? recommended_profile_in_group : recommended_profile

    respond_to do |format|
      format.html { render layout: false }
    end
  end

  def like
    @like = Like.create! profile: @profile, user: current_user
  end

  def pass
    @pass = Pass.create! profile: @profile, user: current_user
  end

  private

  def set_group
    @group = Group.find(params[:group_id]) if params[:group_id]
  end

  def set_profile
    @profile = Profile.find(params[:id]) if params[:id]
  end

  def recommended_profile
    Profile.recommended(current_user.profile).first
  end

  def recommended_profile_in_group
    Profile.recommended(current_user.profile).in_group(@group).first
  end
end
