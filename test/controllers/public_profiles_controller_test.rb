require "test_helper"

class PublicProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @public_profile = profiles(:one)
    @public_profile.update({
      public_code: "123456",
      public: true
    })
  end

  test "should get show when profile is public" do
    get public_profile_path(id: @public_profile.public_code)
    assert_response :success
  end

  test "should return 404 when profile is not public anymore" do
    @public_profile.update({ public: false })

    get public_profile_path(id: @public_profile.public_code)

    assert_response :not_found
  end
end
