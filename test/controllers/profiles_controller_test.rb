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

    born = 18.years.ago.to_date

    assert_difference("Profile.count") do
      post profiles_url,
           params: {
             profile: {
               display_name: "Kitty",
               body: "I love turtles",
               gender: "Man",
               born: born,
               lat: 45.49847190802318,
               lon: -73.43272587208975,
               city: "Saint-Hubert",
               state: "Quebec",
               country: "Canada"
             }
           }
    end

    assert_equal "Kitty", Profile.last.display_name
    assert_equal "I love turtles", Profile.last.body
    assert_equal "Man", Profile.last.gender
    assert_equal born, Profile.last.born
    assert_equal 45.49847190802318, Profile.last.lat
    assert_equal -73.43272587208975, Profile.last.lon
    assert_equal "Saint-Hubert", Profile.last.city
    assert_equal "Quebec", Profile.last.state
    assert_equal "Canada", Profile.last.country
    assert_redirected_to profile_url(Profile.last)
  end

  test "should allow user to specify gender" do
    sign_in users(:gathino)

    post profiles_url,
         params: {
           profile: {
             display_name: "Kitty",
             body: "I love turtles",
             gender: "Let me be more specific",
             specified_gender: "Agender",
             born: 19.years.ago
           }
         }

    assert_equal "Agender", Profile.last.gender
  end

  test "should have an image attached to profile" do
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

  test "should allow for multiple images attached to profile" do
    sign_in users(:gathino)

    post profiles_url,
         params: {
           profile: {
             body: "I love turtles",
             born: 18.years.ago,
             images: [
               fixture_file_upload("rick.jpg", "image/jpeg"),
               fixture_file_upload("rick_in_dallas.jpg", "image/jpeg")
             ]
           }
         }

    assert_redirected_to profile_url(Profile.last)
    assert_equal 2, Profile.last.images.count
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

  test "should save images with update" do
    sign_in users(:gathino)

    patch profile_url(users(:gathino).profile),
          params: {
            profile: {
              body: "I love turtles",
              born: 18.years.ago,
              images: [
                fixture_file_upload("rick.jpg", "image/jpeg"),
                fixture_file_upload("rick_in_dallas.jpg", "image/jpeg")
              ]
            }
          }

    assert_redirected_to profile_url(Profile.last)
    assert_equal 2, Profile.last.images.count
  end

  test "should destroy profile" do
    sign_in users(:gathino)

    assert_difference("Profile.count", -1) { delete profile_url(@profile) }

    assert_redirected_to profiles_url
  end
end
