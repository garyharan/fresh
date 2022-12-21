require "test_helper"

class RoomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:gathino)

    @profile1 = profiles(:one)
    @profile1.images.first.photo.attach(
      io: File.open(Rails.root.join("test/fixtures/files/gathino.png")),
      filename: "gathino.jpg",
      content_type: "image/png"
    )

    @profile2 = profiles(:two)
    @profile2.images.first.photo.attach(
      io: File.open(Rails.root.join("test/fixtures/files/gathino.png")),
      filename: "gathino.jpg",
      content_type: "image/png"
    )

    @room = Room.find_or_create_by_profiles [@profile1, @profile2]
  end

  test "should get index" do
    get rooms_url
    assert_response :success
  end

  test "should show room" do
    get room_url(@room)
    assert_response :success
  end
end
