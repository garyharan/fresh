require "test_helper"

class InvitationsControllerTest < ActionDispatch::IntegrationTest
  test "should save inviter_id in session and redirect to user creation form" do
    @user = users(:gathino)

    get "/invitation/#{@user.id}"

    assert_redirected_to new_user_registration_path
    assert_equal @user.id, session[:inviter_id].to_i
  end
end
