require "test_helper"

class AttendancesControllerTest < ActionDispatch::IntegrationTest
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
    @user = users(:gathino)
    sign_in @user
  end

  test "should create attendance and redirect with notice" do
    assert_difference('Attendance.count', 1) do
      post event_attendances_url(@event)
    end
    assert_redirected_to event_url(@event)
    follow_redirect!
    assert_match 'You have requested to attend this event.', response.body
  end

  test "should destroy attendance and redirect with notice" do
    attendance = Attendance.create!(event: @event, user: @user, status: :requested)
    assert_difference('Attendance.count', -1) do
      delete event_attendance_url(@event, attendance)
    end
    assert_redirected_to event_url(@event)
    follow_redirect!
    assert_match 'You are no longer attending this event.', response.body
  end

  test "should redirect with notice if attendance not found on destroy" do
    delete event_attendance_url(@event, 0)
    assert_redirected_to event_url(@event)
    follow_redirect!
    assert_match 'You are no longer attending this event.', response.body
  end
end
