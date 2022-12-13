class Like < ApplicationRecord
  belongs_to :profile
  belongs_to :author_profile, class_name: "Profile"
end
