class PasswordsMailer < ApplicationMailer
  default from: '"Fresh Dating Administrator" <admin@fresh.dating>'

  def reset(user)
    @user = user
    mail subject: "Reset your Fresh.Dating password", to: user.email_address
  end
end
