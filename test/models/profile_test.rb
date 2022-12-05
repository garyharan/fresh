require "test_helper"

class ProfileTest < ActiveSupport::TestCase
  setup do
    @gathino = profiles(:one)
    @velvet = profiles(:two)
  end

  test "liked_by?(profile) when profile was liked by other profile" do
    Like.create! profile: @velvet, author_profile: @gathino

    assert @velvet.liked_by?(@gathino)
  end

  test "liked_by?(profile) when profile was not liked by other profile" do
    refute @gathino.liked_by?(@velvet)
  end

  test "#likes and #authored_likes" do
    Like.create! profile: @gathino, author_profile: @velvet
    Like.create! profile: @velvet, author_profile: @gathino

    assert_equal 1, @gathino.likes.count
    assert_equal 1, @gathino.authored_likes.count
  end
end
