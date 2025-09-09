class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  has_many :attendances
  has_many :users, through: :attendances

  geocoded_by :location
  after_validation :geocode, if: ->(obj) { obj.location_changed? }

  validates_presence_of :name, :location, :start_time, :end_time
end
