class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"
  helper_method :user_locale

  def user_locale(user)
    user.preferred_language || I18n.default_locale
  end
end
