require "test_helper"

class CardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:gathino)

    @profile = profiles(:one)
  end

  test "should get create" do
    get cards_create_url
    assert_response :success
  end

  test "should get update" do
    get cards_update_url
    assert_response :success
  end

  test "should get destroy" do
    get cards_destroy_url
    assert_response :success
  end
end
