require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "#liked_profiles finds all liked profile" do
    gathino = users(:gathino)
    velvet = users(:velvet)

    gathino.likes.create! profile: velvet.profile

    assert_equal [profiles(:two)], gathino.liked_profiles
  end

  test "#passed_profiles finds all passed profile" do
    gathino = users(:gathino)
    velvet = users(:velvet)

    gathino.passes.create! profile: velvet.profile

    assert_equal [profiles(:two)], gathino.passed_profiles
  end
end
