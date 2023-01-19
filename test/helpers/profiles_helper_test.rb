require "test_helper"

class ProfilesHelperTest < ActionView::TestCase
  test "#imperialize should convert to imperial" do
    assert_equal "5'10\"", imperialize(178)
  end

  test "#online_in_the_last_period should return a human readable string" do
    user = users(:gathino)
    user.update_attribute(:last_sign_in_at, 23.hours.ago)

    assert_equal "Online in the last day", online_in_the_last_period(user.profile)

    user.update_attribute(:last_sign_in_at, 6.days.ago)
    assert_equal "Online in the last week", online_in_the_last_period(user.profile)

    user.update_attribute(:last_sign_in_at, 29.days.ago)
    assert_equal "Online in the last month", online_in_the_last_period(user.profile)

    user.update_attribute(:last_sign_in_at, 2.years.ago)
    assert_equal "Online over a month ago", online_in_the_last_period(user.profile)
  end
end
