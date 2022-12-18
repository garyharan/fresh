module ApplicationHelper
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
end
