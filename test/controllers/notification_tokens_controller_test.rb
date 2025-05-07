require "test_helper"

class NotificationTokensControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:gathino)
    @notification_token_params = { notification_token: { token: "sample_token", platform: "iOS" } }
  end

  test "should create notification token" do
    sign_in @user
    assert_difference -> { @user.notification_tokens.count }, 1 do
      post notification_tokens_url, params: @notification_token_params, headers: { "User-Agent" => "Hotwire Native" }
    end
    assert_response :created
  end

  test "should not create notification token without authentication" do
    assert_no_difference -> { NotificationToken.count } do
      post notification_tokens_url, params: @notification_token_params, headers: { "User-Agent" => "Hotwire Native" }
    end
    assert_response :unauthorized
  end

  test "should not create notification token with invalid params" do
    sign_in @user
    invalid_params = { notification_token: { token: nil, platform: nil } }
    assert_no_difference -> { @user.notification_tokens.count } do
      post notification_tokens_url, params: invalid_params, headers: { "User-Agent" => "Hotwire Native" }
    end
    assert_response :unprocessable_entity
  end
end
