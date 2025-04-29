require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup { sign_in users(:gathino) }

  test "should get create" do
    assert_difference "Like.count" do
      post profile_likes_url(profiles(:two), format: :turbo_stream)
    end
  end

  test "should create a room if like is reciprocal" do
    Room.all.destroy_all
    Like.create! profile: profiles(:one), user: users(:velvet)

    assert_difference "Room.count" do
      post profile_likes_url(profiles(:two), format: :turbo_stream)
    end
  end

  test "should redirect to chat room if like is reciprocal" do
    Like.create! profile: profiles(:one), user: users(:velvet)

    post profile_likes_url(profiles(:two), format: :turbo_stream)
    assert_response :success
    assert_match %r{<turbo-stream action="replace" target="discovery"}, response.body
    assert /Send a Message/ =~ response.body
  end

  test "should get destroy" do
    like = Like.create(profile: profiles(:two), user: profiles(:one).user)

    assert_difference "Like.count", -1 do
      delete profile_like_url(profiles(:two), like, format: :turbo_stream)
    end
  end
end
