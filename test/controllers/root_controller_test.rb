require "test_helper"

class RootControllerTest < ActionDispatch::IntegrationTest
  setup { @gathino = users(:gathino) }

  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should redirect if already logged in with a complete profile" do
    sign_in @gathino
    assert @gathino.profile.complete?
    get root_url
    assert_redirected_to profiles_path
  end

  test "should redirect if profile is incomplete" do
    @gathino = users(:gathino)
    sign_in @gathino
    @gathino.profile.update(display_name: nil)
    refute @gathino.profile.complete?

    get root_url
    assert_redirected_to onboarding_one_path
  end
end
