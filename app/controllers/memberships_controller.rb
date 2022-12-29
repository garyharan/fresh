class MembershipsController < ApplicationController
  before_action :save_group_for_signup_flow
  before_action :authenticate_user!, only: :create

  def show
    @group = Group.find(params[:group_id])
    @memberships = @group.memberships.where.not(profile: current_user.profile)
  end

  def new
    @group = Group.find_by(slug: params[:group_slug])
  end

  def create
    @group = Group.find(params[:group_id])

    @membership = @group.memberships.new(profile: current_user.profile)

    if @membership.save
      redirect_to group_membership_url(@group, @membership)
    else
      render :new
    end
  end

  private

  def save_group_for_signup_flow
    session[:group_id] = params[:group_id]
  end
end
