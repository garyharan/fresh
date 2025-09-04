class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  validates_presence_of :name, :location, :start_time, :end_time
end
