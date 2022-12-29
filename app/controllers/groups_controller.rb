class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: %i[show edit update destroy]

  def index
    @groups = current_user.profile.memberships.map(&:group)
    @managed_groups = current_user.managed_groups
  end

  def show
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html do
          redirect_to groups_url(), notice: "#{@group.name} was successfully created."
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html do
          redirect_to group_url(@group), notice: "group was successfully updated."
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group.destroy

    respond_to do |format|
      format.html do
        redirect_to groups_url, notice: "group was successfully destroyed."
      end
      format.json { head :no_content }
    end
  end

  private

  def set_group
    @group = current_user.profile.groups.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description).merge(user: current_user)
  end
end
