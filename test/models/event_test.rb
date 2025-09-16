require "test_helper"

class EventTest < ActiveSupport::TestCase
  test "calculates the latitude and longtitude after validation if the location changed" do
    event = Event.new(
      name: "Sample Event",
      location: "Montreal, Quebec, Canada",
      start_time: Time.now + 1.day,
      end_time: Time.now + 1.day + 2.hours,
      latitude: 45.5031824,
      longitude: -73.5698065,
      creator: users(:gathino)
    )
    event.save!

    event.location = "Laval, Quebec, Canada"

    event.valid?
    assert_equal 45.5031824, event.latitude
    assert_equal -73.5698065, event.longitude
  end

  test "does not geocode if the location did not change and latitude and longitude are present" do
    event = Event.new(
      name: "Sample Event",
      location: "New York, NY",
      start_time: Time.now + 1.day,
      end_time: Time.now + 1.day + 2.hours,
      latitude: -10000.0,
      longitude: -10000.0,
      creator: users(:gathino)
    )

    event.valid? # Trigger validations and geocoding
    assert_equal -10000.0, event.latitude
    assert_equal -10000.0, event.longitude
  end
end
