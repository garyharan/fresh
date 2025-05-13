module ProfilesHelper
  def imperialize(cm)
    inches = cm * 0.3937
    feet, inches = inches.divmod(12)
    "#{feet}'#{inches.floor}\""
  end

  def previewing?(profile)
    return false unless Current.user
    Current.user.profile == profile
  end

  def assessed?(profile)
    return false unless Current.user
    Assessment.exists?(from_profile: Current.user.profile, to_profile: profile)
  end
end
