class ApplicationController < ActionController::Base
  include ActiveStorage::SetCurrent


  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource.profile.nil?
      new_profile_path
    else
      super
    end
  end
end
