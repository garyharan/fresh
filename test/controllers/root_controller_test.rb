require "test_helper"

class RootControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should redirect if already logged in" do
    sign_in users(:gathino)
    get root_url
    assert_redirected_to profiles_path
  end
end
