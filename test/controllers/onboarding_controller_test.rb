require "test_helper"

class OnboardingControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:gathino)
  end

  test "should require authentication" do
    [onboarding_one_url, onboarding_two_url, onboarding_three_url, onboarding_four_url].each do |url|
      get url
      assert_response :redirect
    end
  end

  test "should get one" do
    sign_in @user
    get onboarding_one_url
    assert_response :success
  end

  test "should update step one" do
    sign_in @user

    patch onboarding_update_one_url, params: { profile: { display_name: "Cão" } }
    assert_redirected_to onboarding_two_url
    assert @user.profile.display_name == "Cão"
  end

  test "should fail to update step one gracefully" do
    sign_in @user

    patch onboarding_update_one_url, params: { profile: { display_name: "" } }
    assert_response :unprocessable_entity
  end

  test "should get two" do
    sign_in @user
    get onboarding_two_url
    assert_response :success
  end

  test "should update step two" do
    sign_in @user
    patch onboarding_update_two_url, params: { profile: { children: "Not sure yet" } }
    assert_redirected_to onboarding_three_url
    assert @user.profile.children == "Not sure yet"
  end

  test "should fail to update step two gracefully" do
    sign_in @user
    patch onboarding_update_two_url, params: { profile: { children: "" } }
    assert_response :unprocessable_entity
  end

  test "should get three" do
    sign_in @user
    get onboarding_three_url
    assert_response :success
  end

  test "should get four" do
    sign_in @user
    get onboarding_four_url
    assert_response :success
  end
end
