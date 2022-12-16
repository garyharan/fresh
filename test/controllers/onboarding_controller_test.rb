require "test_helper"

class OnboardingControllerTest < ActionDispatch::IntegrationTest
  test "should get zero" destroy
  end

  test "should get one" do
    get onboarding_one_url
    assert_response :success
  end

  test "should get two" do
    get onboarding_two_url
    assert_response :success
  end

  test "should get three" do
    get onboarding_three_url
    assert_response :success
  end

  test "should get four" do
    get onboarding_four_url
    assert_response :success
  end
end
