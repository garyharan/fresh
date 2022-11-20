require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get users_update_url
    assert_response :success
  end
end
