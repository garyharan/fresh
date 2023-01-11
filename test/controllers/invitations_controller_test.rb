require "test_helper"

class InvitationsControllerTest < ActionDispatch::IntegrationTest
  test "should save inviter_id in session and redirect to user creation form" do
    @user = users(:gathino)
    @user.invite_code = "1234567890"
    @user.save

    get "/invitation/#{@user.invite_code}"

    assert_redirected_to new_user_registration_path
    assert_equal @user.invite_code, session[:invite_code]
  end
end
