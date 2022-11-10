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

  test "should create image" do
    assert_difference("Image.count") do
      post profile_images_url(@profile),
           params: {
             image: {
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

  test "should get edit" do
    get edit_profile_image_url(@profile, @image)
    assert_response :success
  end

  test "should update image" do
    patch profile_image_url(@profile, @image),
          params: {
            image: {
              profile_id: @image.profile_id
            }
          }
    assert_redirected_to profile_image_url(@profile, @image)
  end

  test "should destroy image" do
    assert_difference("Image.count", -1) do
      delete profile_image_url(@profile, @image)
    end

    assert_redirected_to profile_images_url(@profile)
  end
end
