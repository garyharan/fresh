module UsersHelper
  def user_locale(user)
    user.preferred_language || I18n.default_locale
  end
end
