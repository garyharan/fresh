require "test_helper"

class EventTest < ActiveSupport::TestCase
  test "calculates the latitude and longtitude after validation if the location changed" do
    event = Event.new(
      name: "Sample Event",
      location: "New York, NY",
      start_time: Time.now + 1.day,
      end_time: Time.now + 1.day + 2.hours,
      creator: users(:gathino)
    )
    assert_nil event.latitude
    assert_nil event.longitude

    event.valid? # Trigger validations and geocoding
    assert_not_nil event.latitude
    assert_not_nil event.longitude
  end
end
