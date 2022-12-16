class ApplicationController < ActionController::Base
  include ActiveStorage::SetCurrent


  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource.profile.nil?
      onboarding_one_url
    else
      super
    end
  end
end
