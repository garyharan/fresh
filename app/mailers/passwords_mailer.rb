class PasswordsMailer < ApplicationMailer
  default from: "admin@fresh.dating"

  def reset(user)
    @user = user
    mail subject: "Reset your password", to: user.email_address
  end
end
