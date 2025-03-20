require "test_helper"

class MessageTest < ActiveSupport::TestCase
  setup do
    @gathino = users(:gathino)
    @velvet  = users(:velvet)

    @messages = [messages(:one), messages(:two)]

    @messages.each do |message|
      Read.create! user: @gathino, message: message
    end

    @unread = Message.create! room: rooms(:one), user: @velvet, body: "sent by velvet"
  end

  test ".unread_by returns messages that are unread" do
    assert_equal [@unread], Message.unread_by(@gathino)
  end

  test ".unread_by does not return messages that are read" do
    @messages.each do |message|
      refute_equal [message], Message.unread_by(@gathino)
    end
  end

  test ".unread_by does not return messages you sent" do
    assert_equal Message.unread_by(@gathino), [@unread]
    assert_equal Message.unread_by(@velvet), [messages(:one)]
  end

  test ".unread_by ignores messages in rooms you are not part of" do
    other_room = rooms(:two)
    other_message = Message.create! room: other_room, user: users(:mariet), body: "message in another room"

    assert_not_includes Message.unread_by(@gathino), other_message
  end

  test ".after_create sends a notification to the recipient" do
    @gathino = users(:gathino)
    @velvet  = users(:velvet)

    @room = Room.find_or_create_by_profiles([@gathino.profile, @velvet.profile])

    assert_called(UnreadChannel, :broadcast_to, times: 1) do
      @message = Message.create! room: @room, user: @velvet, body: "Hello there"
    end
  end
end
