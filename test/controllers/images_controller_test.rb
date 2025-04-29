require "test_helper"

class ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:gathino)

    @profile = profiles(:one)
    @image = images(:one)
  end

  test "should get index" do
    get profile_images_url(@profile)
    assert_response :success
  end

  test "should get new" do
    get new_profile_image_url(@profile)
    assert_response :success
  end

  test "should create single image" do
    assert_difference("Image.count") do
      post profile_images_url(@profile),
           params: {
             image: {
               photo:
                 fixture_file_upload(
                   "test/fixtures/files/captain.jpeg",
                   "image/jpeg"
                 ),
               profile_id: @image.profile_id
             }
           }
    end
  end

  test "should create multiple images" do
    assert_difference("Image.count", +2) do
      post profile_images_url(@profile),
           params: {
             image: {
               photo: [
                  fixture_file_upload("test/fixtures/files/captain.jpeg", "image/jpeg"),
                  fixture_file_upload("test/fixtures/files/gathino.png", "image/png")
                ],
               profile_id: @image.profile_id
             }
           }
    end

    assert_redirected_to profile_images_url(@profile)
  end

  test "should show image" do
    get profile_image_url(@profile, @image)
    assert_response :success
  end

  test "should destroy image" do
    assert_difference("Image.count", -1) do
      delete profile_image_url(@profile, @image)
    end

    assert_redirected_to profile_images_url(@profile)
  end
end
