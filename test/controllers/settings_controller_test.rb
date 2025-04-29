require "test_helper"

class SettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:gathino)
  end

  test "should require login" do
    get settings_url
    assert_response :redirect

    get settings_invite_url
    assert_response :redirect
  end

  test "should get settings" do
    sign_in @user
    get settings_url
    assert_response :success
  end
end
