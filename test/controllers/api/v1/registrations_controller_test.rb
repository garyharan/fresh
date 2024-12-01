require './test/test_helper'

class Api::V1::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should create user with email and password" do
    assert_difference('User.count', 1) do
      post api_v1_user_registration_url, params: { user: { email: 'test@example.com', password: 'password123' } }
    end

    assert_response :success
  end

  test "should respond with json token" do
    post api_v1_user_registration_url, params: { user: { email: 'test@example.com', password: 'password123' } }
    assert_not_nil json_response['token']
  end
end
