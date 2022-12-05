class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  broadcasts_to :room
end
