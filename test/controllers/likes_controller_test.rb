require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup { sign_in users(:gathino) }

  test "should get create" do
    assert_difference "Like.count" do
      post profile_likes_url(profiles(:two), format: :turbo_stream)
    end
  end

  test "should get destroy" do
    like =
      Like.create(
        profile_id: profiles(:two).id,
        user: profiles(:one).user
      )
    assert_difference "Like.count", -1 do
      delete profile_like_url(profiles(:two), like, format: :turbo_stream)
    end
  end
end
