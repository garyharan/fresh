class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save && Profile.create(user_id: @user.id, step: :creation)
      redirect_to root_url, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    @user = Current.user

    @user.update!(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:maximum_distance, :password, :email_address)
  end
end
