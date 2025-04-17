require "test_helper"

class GeneralControllerTest < ActionDispatch::IntegrationTest
  test "should get about" do
    get general_about_url
    assert_response :success
  end
end
