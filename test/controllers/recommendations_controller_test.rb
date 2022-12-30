require "test_helper"

class RecommendationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gathino = users(:gathino)
    @velvet  = users(:velvet)

    sign_in @gathino
  end

  test "should get index" do
    get recommendations_url
    assert_response :success
  end

  test "should get like" do
    post like_recommendation_url id: @velvet.profile.id
    assert_response :success
  end

  test "should get pass" do
    post pass_recommendation_url id: @velvet.profile.id
    assert_response :success
  end
end
