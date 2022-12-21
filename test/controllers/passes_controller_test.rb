require "test_helper"

class PassesControllerTest < ActionDispatch::IntegrationTest
  setup { sign_in users(:gathino) }

  test "should get create" do
    assert_difference "Pass.count" do
      post profile_passes_url(profiles(:two), format: :turbo_stream)
    end
  end

  test "should get destroy" do
    pass = Pass.create(profile: profiles(:two), user: profiles(:one).user)

    assert_difference "Pass.count", -1 do
      delete profile_pass_url(profiles(:two), pass, format: :turbo_stream)
    end
  end
end
