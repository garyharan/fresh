require "test_helper"

class EventsHelperTest < ActionView::TestCase
  test "#event_time_range returns only start time when end_time is nil" do
    event = Event.new(
      start_time: DateTime.new(2012, 6, 12, 10, 0),
      end_time: nil
    )
    expected = "June 12, 2012 10:00 AM"
    assert_equal expected, event_time_range(event)
  end

  test "#event_time_range returns start and end time on same day" do
    event = Event.new(
      start_time: DateTime.new(2012, 6, 12, 10, 0),
      end_time: DateTime.new(2012, 6, 12, 12, 30)
    )
    expected = "June 12, 2012 10:00 AM - 12:30 PM"
    assert_equal expected, event_time_range(event)
  end

  test "#event_time_range returns start and end time on different days" do
    event = Event.new(
      start_time: DateTime.new(2009, 11, 22, 10, 0),
      end_time: DateTime.new(2012, 6, 12, 10, 30)
    )
    expected = "November 22, 2009 10:00 AM - June 12, 2012 10:30 AM"
    assert_equal expected, event_time_range(event)
  end

  test "#google_calendar_url returns a valid URL" do
    event = Event.new(
      name: "My Event",
      description: "This is my event.",
      location: "123 Main St, Anytown, USA",
      start_time: DateTime.new(2024, 7, 4, 15, 0),
      end_time: DateTime.new(2024, 7, 4, 17, 0)
    )

    assert_equal(
      "https://www.google.com/calendar/render?action=TEMPLATE&ctz=UTC&dates=20240704T150000Z%2F20240704T170000Z&details=This+is+my+event.&location=123+Main+St%2C+Anytown%2C+USA&sprop=http%3A%2F%2Ftest.host%2Fevents%2F&text=My+Event",
      google_calendar_url(event)
    )
  end
end
