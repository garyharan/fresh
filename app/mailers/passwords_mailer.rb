class PasswordsMailer < ApplicationMailer
  default from: '"Fresh Dating Administrator" <admin@fresh.dating>'

  def reset(user)
    @user = user
    mail subject: t('passwords.reset_mailer_subject', locale: user_locale(user)), to: user.email_address
  end
end
