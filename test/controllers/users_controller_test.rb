require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should update distance" do
    @user = users(:gathino)

    sign_in @user

    @user.distance = 10
    @user.save!

    patch user_url(@user), params: { user: { distance: 100 } }

    assert_response :success

    assert @user.reload.distance == 100
  end

  test "should require sign in" do
    patch user_url(id: 1), params: { user: { distance: 100 } }

    assert_response :redirect
  end
end
