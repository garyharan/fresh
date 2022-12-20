class ProfileValidator < ActiveModel::Validator
  def validate(profile)
    if profile.step.nil? || profile.step == 1
      if profile.display_name.blank?
        profile.errors.add("display_name", "can't be blank")
      end
      if profile.gender_id.blank?
        profile.errors.add("gender_id", "must be filled out")
      end
      if profile.born_on.blank?
        profile.errors.add("born_on", "must be filled out")
      end
      profile.errors.add("city", "must be filled out") if profile.city.blank?
      profile.errors.add("state", "must be filled out") if profile.state.blank?
      if profile.country.blank?
        profile.errors.add("country", "must be filled out")
      end
    end

    if profile.step.nil? || profile.step == 2
      if profile.attractions.empty?
        profile.errors.add("attractions", "must be filled out")
      end
      if profile.children.blank?
        profile.errors.add("children", "must be filled out")
      end
      if profile.relationship_style.blank?
        profile.errors.add("relationship_style", "must be filled out")
      end
      if profile.height.blank?
        profile.errors.add("height", "must be filled out")
      end
      if profile.smoking.blank?
        profile.errors.add("smoking", "must be filled out")
      end
      if profile.drinking.blank?
        profile.errors.add("drinking", "must be filled out")
      end
    end
  end
end
