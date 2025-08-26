class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]

  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new(user_params)
    @user.first_signin_ip_address = request.remote_ip

    if @user.save && Profile.create(user_id: @user.id, step: :creation) && start_new_session_for(@user)
      redirect_to root_url, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    @user = Current.user

    @user.update!(user_params)
    I18n.locale = @user.preferred_language if @user.preferred_language.present?
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @user = Current.user

    @user.destroy
    terminate_session
    flash.notice = "Your account and all associated data has been deleted."
    refresh_or_redirect_to root_path, notice: "Your account and all associated data have been permanently deleted."
  rescue => e
    redirect_to settings_path, alert: "Error deleting account: #{e.message}"
  end

  private

  def user_params
    params.require(:user).permit(:maximum_distance, :password, :email_address, :preferred_language)
  end
end
