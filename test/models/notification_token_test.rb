require "test_helper"

class NotificationTokenTest < ActiveSupport::TestCase
  test "should belong to a user" do
    association = NotificationToken.reflect_on_association(:user)
    assert_equal :belongs_to, association.macro
  end

  test "should validate presence of token" do
    notification_token = NotificationToken.new(platform: "iOS", user: users(:gathino))
    assert_not notification_token.valid?
    assert_includes notification_token.errors[:token], "can't be blank"
  end

  test "should validate inclusion of platform in allowed values" do
    notification_token = NotificationToken.new(token: "abc123", platform: "Android", user: users(:gathino))
    assert_not notification_token.valid?
    assert_includes notification_token.errors[:platform], "is not included in the list"
  end

  test "should be valid with valid attributes" do
    notification_token = NotificationToken.new(token: "abc123", platform: "iOS", user: users(:gathino))
    assert notification_token.valid?
  end
end
