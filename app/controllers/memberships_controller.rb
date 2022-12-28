class MembershipsController < ApplicationController
  before_action :save_group_for_signup_flow
  before_action :authenticate_user!, only: :create

  before_action :set_group

  def new
  end

  def create
    @membership = @group.memberships.new(user: current_user)

    if @membership.save
      redirect_to group_url(@group)
    else
      render :new
    end
  end

  private

  def set_group
    @group = Group.find_by(slug: params[:group_slug])
  end

  def save_group_for_signup_flow
    session[:group_id] = params[:group_id]
  end
end
