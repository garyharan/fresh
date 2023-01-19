require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should update distance" do
    @user = users(:gathino)

    sign_in @user

    @user.maximum_distance = 10
    @user.save!

    patch user_url(@user), params: { user: { maximum_distance: 100 } }

    assert_response :success

    assert @user.reload.maximum_distance == 100
  end

  test "should require sign in" do
    patch user_url(id: 1), params: { user: { distance: 100 } }

    assert_response :redirect
  end
end
