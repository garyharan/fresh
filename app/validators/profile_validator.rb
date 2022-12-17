class ProfileValidator < ActiveModel::Validator
  def validate(profile)
    if profile.display_name.blank?
      profile.errors.add("display_name", "can't be blank")
    end

    if profile.gender_id.blank?
      profile.errors.add("gender_id", "must be filled out")
    end

    if profile.born_on.blank?
      profile.errors.add("born_on", "must be filled out")
    end

    if profile.city.blank?
      profile.errors.add("city", "must be filled out")
    end

    if profile.state.blank?
      profile.errors.add("state", "must be filled out")
    end

    if profile.country.blank?
      profile.errors.add("country", "must be filled out")
    end

    if profile.step == 2
    end

  end
end
