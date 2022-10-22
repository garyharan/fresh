class Profile < ApplicationRecord
  belongs_to :user

  has_many_attached(:images, dependent: :destroy) do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
    attachable.variant :board, resize_to_limit: [300, 300]
  end

  attr_accessor :specified_gender

  POSSIBLE_GENDERS = [
    "Woman",
    "Man",
    "Non-Binary and/or Two Spirit Person"
    # "Let me be more specific" Do not add or you risk breaking ProfileController#profile_params
  ]
end
