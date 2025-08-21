class Gender < ApplicationRecord
  def display_label
    I18n.t("genders.#{label.downcase.gsub(/[^a-z0-9]/, '_')}", default: label)
  end
end
