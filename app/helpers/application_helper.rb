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

  def gender_choices
    Profile::POSSIBLE_GENDERS
  end

  def age(dob)
    now = Time.now.utc.to_date
    now.year - dob.year -
      (
        if (
             now.month > dob.month ||
               (now.month == dob.month && now.day >= dob.day)
           )
          0
        else
          1
        end
      )
  end
end
