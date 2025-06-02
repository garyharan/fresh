module ApplicationHelper
  def hotwire_native_title(string)
    case string
    when "no_title", ""
      "‎ " # This is used to hide the title in the native app
    else
      string
    end
  end

  def age(dob)
    return "??" if dob.nil?

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

  def profile_percentages(profiles)
    factor = 1.0 / profiles.size

    profiles.inject(Hash.new(0)) do |hash, profile|
      if profile.gender.present?
        hash[profile.gender.label] += factor
      else
        hash["Unknown"] += factor
      end
      hash
    end
  end

  def turbo_native?
    request.variant.include?(:turbo_native)
  end
end
