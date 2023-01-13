require "test_helper"

class Admin::ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_profiles_index_url
    assert_response :success
  end
end
