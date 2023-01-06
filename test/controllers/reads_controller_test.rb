require 'test_helper'

class ReadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gathino = users(:gathino)
    @velvet  = users(:velvet)

    @room = Room.find_or_create_by_profiles([@gathino.profile, @velvet.profile])

    @message = Message.create!(room: @room, user: @gathino, body: 'Hello, world!')

    sign_in @gathino
  end

  test "should create a read" do
    assert_difference('Read.count') do
      post reads_url, params: { message_id: @message.id }
    end

    assert_response :success
  end
end

