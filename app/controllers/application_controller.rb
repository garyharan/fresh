class ApplicationController < ActionController::Base
  include Authentication
  include DeviceVariants
  include ActiveStorage::SetCurrent

  helper_method :mobile?

  def mobile?
    request.user_agent.include?('Hotwire')
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource.profile.nil?
      onboarding_one_url
    else
      super
    end
  end

  private

  def force_profile_completion
    redirect_to new_profile_url unless Current.user&.profile&.complete?
  end
end
