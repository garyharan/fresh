require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = Event.create!(
      name: "Love Reunion",
      location: "Romantic Place",
      start_time: DateTime.new(2024, 6, 12, 10, 0),
      end_time: DateTime.new(2024, 6, 12, 12, 30),
      maximum_attendees: 100,
      allow_wait_list: true,
      creator: users(:gathino)
    )
  end

  test "should get index" do
    sign_in users(:gathino)

    get events_url
    assert_response :success
  end

  test "should get new" do
    sign_in users(:gathino)
    get new_event_url
    assert_response :success
  end

  test "should create event" do
    sign_in users(:gathino)

    assert_difference("Event.count") do
      post events_url, params: { event: { allow_wait_list: @event.allow_wait_list, end_time: @event.end_time, location: @event.location, maximum_attendees: @event.maximum_attendees, name: @event.name, start_time: @event.start_time } }
    end

    assert_redirected_to events_path
    assert_equal users(:gathino), Event.last.creator
  end

  test "should show event" do
    get event_url(@event)
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:gathino)

    get edit_event_url(@event)
    assert_response :success
  end

  test "should only get edit if we are owner" do
    sign_in users(:velvet)

    get edit_event_url(@event)
    assert_response :not_found
  end

  test "should update event" do
    sign_in users(:gathino)
    patch event_url(@event), params: { event: { allow_wait_list: @event.allow_wait_list, end_time: @event.end_time, location: @event.location, maximum_attendees: @event.maximum_attendees, name: @event.name, start_time: @event.start_time } }
    assert_redirected_to events_path
  end

  test "should only update if we are owner" do
    sign_in users(:velvet)

    patch event_url(@event), params: { event: { allow_wait_list: @event.allow_wait_list, end_time: @event.end_time, location: @event.location, maximum_attendees: @event.maximum_attendees, name: @event.name, start_time: @event.start_time } }
    assert_response :not_found
  end

  test "should destroy event" do
    sign_in users(:gathino)
    assert_difference("Event.count", -1) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
  end

  test "should only destroy event if we are owner" do
    sign_in users(:velvet)
    assert_no_difference("Event.count") do
      delete event_url(@event)
    end

    assert_response :not_found
  end
end
