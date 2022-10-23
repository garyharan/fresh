module ProfilesHelper
  def imperialize(cm)
    inches = cm * 0.3937
    feet, inches = inches.divmod(12)
    "#{feet}'#{inches.floor}\""
  end
end
