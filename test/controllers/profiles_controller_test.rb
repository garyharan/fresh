require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profile = profiles(:one)

    @profile.images.first.photo.attach(
      io: File.open(Rails.root.join("test/fixtures/files/gathino.png")),
      filename: "gathino.jpg",
      content_type: "image/png"
    )
  end

  test "should be logged in" do
    get profiles_url
    assert_redirected_to user_session_path
  end

  test "should get index" do
    sign_in users(:velvet)
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
               gender_id: Gender.first.id,
               gender_ids: [Gender.first.id, Gender.last.id],
               children: "Have & don't want more",
               relationship_style: "Non-monogamous",
               born: born,
               height: 178,
               drinking: "Occasionally",
               smoking: "Never",
               lat: 45.49847190802318,
               lon: -73.43272587208975,
               city: "Saint-Hubert",
               state: "Quebec",
               country: "Canada"
             }
           }
    end

    profile = Profile.last

    assert_equal "Kitty", profile.display_name
    assert_equal Gender.first.label, profile.gender.label
    assert_equal 2, profile.genders.count
    assert_equal "Have & don't want more", profile.children
    assert_equal "Non-monogamous", profile.relationship_style
    assert_equal born, profile.born
    assert_equal 178, profile.height
    assert_equal "Occasionally", profile.drinking
    assert_equal "Never", profile.smoking
    assert_equal 45.49847190802318, profile.lat
    assert_equal -73.43272587208975, profile.lon
    assert_equal "Saint-Hubert", profile.city
    assert_equal "Quebec", profile.state
    assert_equal "Canada", profile.country
    assert_redirected_to profile_url(profile)
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
    patch profile_url(@profile), params: { profile: { born: @profile.born } }
    assert_redirected_to profile_url(@profile)
  end

  test "should destroy profile" do
    sign_in users(:gathino)

    assert_difference("Profile.count", -1) { delete profile_url(@profile) }

    assert_redirected_to profiles_url
  end
end
