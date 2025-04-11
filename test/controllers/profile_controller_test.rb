require "test_helper"

class ProfileControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:gathino)
  end

  test "should get show" do
    get profile_show_url
    assert_response :success
  end
end
