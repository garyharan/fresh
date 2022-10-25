require "test_helper"

class ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profile = users(:gathino).profile
    @profile.images.attach fixture_file_upload("rick.jpg", "image/jpeg")
  end

  test "should be logged in" do
    get images_url
    assert_redirected_to user_session_path
  end

  test "should show index" do
    sign_in users(:gathino)

    get images_url
    assert_response :success
  end

  test "should delete image" do
    sign_in users(:gathino)

    assert_difference("@profile.images.count", -1) do
      delete image_url(@profile.images.last.id), xhr: true
    end

    assert_response :success
    assert_equal "", response.body
  end
end
