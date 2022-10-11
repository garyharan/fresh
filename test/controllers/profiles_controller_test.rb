require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup { @profile = profiles(:one) }

  test "should be logged in" do
    get profiles_url
    assert_redirected_to user_session_path
  end

  test "should get index" do
    sign_in users(:gathino)
    get profiles_url
    assert_response :success
  end

  test "should redirect to profile creation page if you do not have a profile yet" do
    sign_in users(:no_profile_yet)

    get profiles_url
    assert_redirected_to new_profile_url
  end

  test "should get new" do
    sign_in users(:gathino)
    get new_profile_url
    assert_response :success
  end

  test "should create profile" do
    sign_in users(:gathino)

    assert_difference("Profile.count") do
      post profiles_url,
           params: {
             profile: {
               body: "I love turtles",
               born: 18.years.ago
             }
           }
    end

    assert_redirected_to profile_url(Profile.last)
  end

  test "should have images attached to profile" do
    sign_in users(:gathino)

    image = fixture_file_upload("rick.jpg", "image/jpeg")
    post profiles_url,
         params: {
           profile: {
             body: "I love turtles",
             born: 18.years.ago,
             images: [image]
           }
         }

    assert_redirected_to profile_url(Profile.last)
    assert Profile.last.images.attached?
  end

  test "should show profile" do
    sign_in users(:gathino)
    get profile_url(@profile)
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:gathino)
    get edit_profile_url(@profile)
    assert_response :success
  end

  test "should update profile" do
    sign_in users(:gathino)
    patch profile_url(@profile),
          params: {
            profile: {
              body: @profile.body,
              born: @profile.born
            }
          }
    assert_redirected_to profile_url(@profile)
  end

  test "should destroy profile" do
    sign_in users(:gathino)

    assert_difference("Profile.count", -1) { delete profile_url(@profile) }

    assert_redirected_to profiles_url
  end
end
