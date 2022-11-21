class Profile < ApplicationRecord
  belongs_to :user
  has_many :images, dependent: :destroy
  belongs_to :gender, required: false

  has_and_belongs_to_many :genders

  attr_accessor :specified_gender

  POSSIBLE_GENDERS = ["Woman", "Man", "Non-Binary and/or Two Spirit Person"]
  POSSIBLE_CHILDREN_CONFIGURATIONS = [
    "Want someday",
    "Don't want",
    "Have & want more",
    "Have & don't want more",
    "Not sure yet"
  ]
  POSSIBLE_RELATIONSHIP_STYLES = [
    "Monogamous",
    "Non-monogamous",
    "I would rather not say"
  ]
  POSSIBLE_SMOKING_OPTIONS = [
    "Never",
    "Occasionally",
    "Often",
    "Prefer not to say"
  ]
  POSSIBLE_DRINKING_OPTIONS = [
    "Never",
    "Occasionally",
    "Often",
    "Prefer not to say"
  ]
end
