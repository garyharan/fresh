class UsersController < ApplicationController
  before_action :authenticate_user!

  def update
    @user = current_user

    @user.update!(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:maximum_distance)
  end
end
