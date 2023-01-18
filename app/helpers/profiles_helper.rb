module ProfilesHelper
  def imperialize(cm)
    inches = cm * 0.3937
    feet, inches = inches.divmod(12)
    "#{feet}'#{inches.floor}\""
  end

  def online_in_the_last_period(profile)
    last_sign_in = profile.user.last_sign_in_at

    if 24.hours.ago < last_sign_in
      "Online in the last day"
    elsif 7.days.ago < last_sign_in
      "Online in the last week"
    elsif 30.days.ago < last_sign_in
      "Online in the last month"
    else
      "Online over a month ago"
    end
  end
end
