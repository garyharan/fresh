class RootController < ApplicationController
  before_action :redirect_if_logged_in

  layout "root"

  def index
  end

  private

  def redirect_if_logged_in
    if current_user.profile&.complete?
      redirect_to profiles_path
    else
      redirect_to onboarding_one_path
    end
  end
end
