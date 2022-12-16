class ProfileValidator < ActiveModel::Validator
  def validate(record)
    if record.display_name.blank?
      record.errors[:name] << "can't be blank"
    end
  end
end
