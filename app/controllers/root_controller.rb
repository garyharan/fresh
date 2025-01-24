class RootController < ApplicationController
  allow_unauthenticated_access
  before_action :redirect_if_logged_in

  def index
  end

  private

  def redirect_if_logged_in
    return unless authenticated?

    if Current.user&.profile&.complete?
      redirect_to profiles_path
    else
      redirect_to onboarding_one_path
    end
  end
end
