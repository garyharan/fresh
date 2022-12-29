class MembershipsController < ApplicationController
  def show
    @group = Group.find(params[:group_id])
    @memberships = @group.memberships.where.not(profile: current_user.profile)
  end

  def new
    @group = Group.find_by(slug: params[:group_slug])
  end

  def create
    @group = Group.find(params[:group_id])

    if user_signed_in?
      @membership = @group.memberships.create!(profile: current_user.profile)
      redirect_to group_membership_path(@group)
    else
      save_group_for_signup_flow
      flash[:notice] = "You need to sign up or log in to join this group."
      redirect_to new_user_registration_path
    end
  end

  private

  def save_group_for_signup_flow
    session[:group_id] = params[:group_id]
  end
end
