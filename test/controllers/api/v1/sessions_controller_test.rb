require './test/test_helper.rb'

class Api::V1::SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create! email: "john@doe.com", password: "password", password_confirmation: "password"
  end

  test "should create auth token with valid credentials" do
    post api_v1_user_session_url, params: { user: { email: @user.email, password: @user.password } }, as: :json
    assert_response :success
    assert_not_nil json_response['token']
  end

  test "should not create auth token with invalid credentials" do
    post api_v1_user_session_url, params: { user: { email: @user.email, password: 'wrong_password' } }, as: :json
    assert_response :unauthorized
    assert_not_nil json_response['error']
  end

  private

  def json_response
    @json_response ||= JSON.parse(response.body)
  end
end
