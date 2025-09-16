class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  has_many :attendances
  has_many :users, through: :attendances

  geocoded_by :location
  after_validation :geocode, if: :should_geocode?

  validates_presence_of :name, :location, :start_time, :end_time

  private

  def should_geocode?
    if new_record?
      location_changed? && latitude.blank? && longitude.blank?
    else
      latitude.blank? || longitude.blank?
    end
  end
end
