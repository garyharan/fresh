class ApplicationController < ActionController::Base
  include Authentication
  include DeviceVariants
  include ActiveStorage::SetCurrent

  helper_method :hotwire_native?

  after_action :set_locale

  def hotwire_native?
    !!(request.user_agent =~ /Hotwire Native/)
  end

  private

  def force_profile_completion
    redirect_to new_profile_url unless Current.user&.profile&.complete?
  end

  def set_locale
    locale = locale_from_params || user_preferred_locale || locale_from_accept_language_header
    I18n.locale = I18n.available_locales.include?(locale&.to_sym) ? locale.to_sym : I18n.default_locale
  end

  def locale_from_params
    params[:locale]
  end

  def user_preferred_locale
    Current.user&.preferred_language
  end

  def locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first
  end
end
