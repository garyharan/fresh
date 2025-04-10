require "test_helper"

class SettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:gathino)
  end

  test "should require login" do
    get settings_url
    assert_response :redirect

    get settings_public_url
    assert_response :redirect

    get settings_invite_url
    assert_response :redirect
  end

  test "should get settings" do
    sign_in @user
    get settings_url
    assert_response :success
  end

  test "udpate should recede_or_redirect_to_settings" do

  end

  test "should toggle public settings" do
    @user = users(:gathino)
    sign_in @user

    refute @user.profile.public?
    post settings_toggle_public_url
    assert @user.profile.reload.public?
    post settings_toggle_public_url
    refute @user.profile.reload.public?
  end
end
