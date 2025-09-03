require "test_helper"

class EventsHelperTest < ActionView::TestCase
  test "returns only start time when end_time is nil" do
    event = Event.new(
      start_time: DateTime.new(2012, 6, 12, 10, 0),
      end_time: nil
    )
    expected = "June 12, 2012 10:00 AM"
    assert_equal expected, event_time_range(event)
  end

  test "returns start and end time on same day" do
    event = Event.new(
      start_time: DateTime.new(2012, 6, 12, 10, 0),
      end_time: DateTime.new(2012, 6, 12, 12, 30)
    )
    expected = "June 12, 2012 10:00 AM - 12:30 PM"
    assert_equal expected, event_time_range(event)
  end

  test "returns start and end time on different days" do
    event = Event.new(
      start_time: DateTime.new(2009, 11, 22, 10, 0),
      end_time: DateTime.new(2012, 6, 12, 10, 30)
    )
    expected = "November 22, 2009 10:00 AM - June 12, 2012 10:30 AM"
    assert_equal expected, event_time_range(event)
  end
end
