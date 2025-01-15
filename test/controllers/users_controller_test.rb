require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should create a user" do
    assert_difference('User.count', 1) do
      post users_url, params: { user: { email_address: 'test@example.com', password: 'password' } }
    end

    assert_response :success
  end

  test "should not create a user if email already exists" do
    User.create!(email_address: 'test@example.com', password: 'password')

    assert_no_difference('User.count') do
      post users_url, params: { user: { email_address: 'test@example.com', password: 'password' } }
    end

    assert_response :unprocessable_entity
  end

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
