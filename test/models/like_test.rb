require "test_helper"

class LikeTest < ActiveSupport::TestCase
  test "a room gets created when both profiles like one another" do
    gathino = profiles(:one)
    velvet = profiles(:two)

    Room.destroy_all
    Like.destroy_all

    assert_difference "Room.count", 1 do
      gathino.likes.create profile: gathino
      Like.create! profile: velvet, author_profile: gathino
    end

    assert_equal 2, Like.count
  end
end
