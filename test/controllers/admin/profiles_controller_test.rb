require "test_helper"

class Admin::ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get redirected to authentication if not logged in" do
    get admin_profiles_url
    assert_response :redirect
  end

  test "normal users gets told they cannot see this page" do
    sign_in users(:gathino)
    get admin_profiles_url

    assert_response :redirect
    assert_equal "Not authorized.",  flash[:alert]
  end

  test "only admins can see this page" do
    @user = users(:gathino)
    @user.update_column :admin, true

    sign_in @user
    get admin_profiles_url

    assert_response :success
  end
end
