require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gathino = users(:gathino)
    @velvet  = users(:velvet)

    @room = Room.find_or_create_by_profiles([@gathino.profile, @velvet.profile])

    sign_in @gathino
  end

  test "should create message" do
    assert_difference("Message.count") do
      post room_messages_url(@room, format: :turbo_stream), params: { message: { body: "Hello" } }
    end
  end
end
