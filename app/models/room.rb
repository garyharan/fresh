class Room < ApplicationRecord
  has_and_belongs_to_many :profiles

  has_many :messages, class_name: "Message", dependent: :destroy

  def name
    profiles.map(&:display_name).to_sentence
  end
end
