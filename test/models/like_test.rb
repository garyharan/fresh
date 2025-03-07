require "test_helper"

class LikeTest < ActiveSupport::TestCase
  test "creating a like destroys any passes for the same profile" do
    gathino = users(:gathino)
    velvet  = users(:velvet)
    eva     = users(:eva)

    velvet_pass  = Pass.create! profile: gathino.profile, user: velvet
    eva_pass     = Pass.create! profile: velvet.profile, user: eva
    gathino_pass = Pass.create! profile: eva.profile, user: gathino

    assert_difference "Like.count", 1 do
      assert_difference "Pass.count", -1 do
        Like.create! profile: gathino.profile, user: velvet
      end
    end
  end

  test "reciprocated? returns true if it is" do
    gathino = users(:gathino)
    velvet  = users(:velvet)
    eva     = users(:eva)

    velvet_likes_gathino = Like.create! profile: gathino.profile, user: velvet
    gathino_likes_velvet = Like.create! profile: velvet.profile,  user: gathino
    eva_likes_gathino    = Like.create! profile: gathino.profile, user: eva

    assert velvet_likes_gathino.reciprocated?
    assert gathino_likes_velvet.reciprocated?

    refute eva_likes_gathino.reciprocated?
  end

  test "creating a reciprocal like creates a room" do
    Room.all.destroy_all

    gathino = users(:gathino)
    velvet  = users(:velvet)

    Like.create! profile: gathino.profile, user: velvet

    assert_difference "Room.count", 1 do
      Like.create! profile: velvet.profile, user: gathino
    end
  end
end
