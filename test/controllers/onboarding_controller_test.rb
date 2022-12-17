require "test_helper"

class OnboardingControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:gathino)
    sign_in @user
  end

  test "should require authentication" do
    sign_out @user

    [onboarding_one_url, onboarding_two_url, onboarding_three_url, onboarding_four_url].each do |url|
      get url
      assert_response :redirect
    end
  end

  test "should get one" do
    get onboarding_one_url
    assert_response :success
  end

  test "should update step one" do
    patch onboarding_one_url, params: { profile: { display_name: "Cão" } }
    assert @user.profile.display_name == "Cão"
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
