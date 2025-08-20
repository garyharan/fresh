class ApplicationController < ActionController::Base
  include Authentication
  include DeviceVariants
  include ActiveStorage::SetCurrent

  helper_method :hotwire_native?

  before_action :set_locale

  def hotwire_native?
    !!(request.user_agent =~ /Hotwire Native/)
  end

  private

  def force_profile_completion
    redirect_to new_profile_url unless Current.user&.profile&.complete?
  end

  SUPPORTED_LOCALES = %i[en fr]

  def set_locale
    I18n.locale = requested_locale || I18n.default_locale
  end

  def requested_locale
    locale = params[:locale] || locale_from_accept_language_header
    locale if locale.present? && SUPPORTED_LOCALES.include?(locale.to_sym)
  end

  def locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first&.to_sym
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
