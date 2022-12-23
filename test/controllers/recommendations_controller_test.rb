require "test_helper"

class RecommendationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get recommendations_index_url
    assert_response :success
  end

  test "should get like" do
    get recommendations_like_url
    assert_response :success
  end

  test "should get pass" do
    get recommendations_pass_url
    assert_response :success
  end
end
