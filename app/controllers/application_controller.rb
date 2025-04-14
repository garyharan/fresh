class ApplicationController < ActionController::Base
  include Authentication
  include DeviceVariants
  include ActiveStorage::SetCurrent

  helper_method :hotwire_native?

  def hotwire_native?
    !!(request.user_agent =~ /Hotwire Native/)
  end

  private

  def force_profile_completion
    redirect_to new_profile_url unless Current.user&.profile&.complete?
  end
end
