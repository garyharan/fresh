module PartnershipsHelper
  def marked_as_partner?(profile)
    return false unless Current.user
    Current.user.profile.partnerships.exists?(to_profile: profile)
  end
end
