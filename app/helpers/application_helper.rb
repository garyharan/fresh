module ApplicationHelper
  def display_name(user)
    if user.profile && user.profile.display_name
      user.profile.display_name
    else
      user.email
    end
  end

  def avatar_image_url(user)
    user.profile.images.first if user.profile && user.profile.images.any?
  end
end
