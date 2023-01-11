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

  test "saves a unique invite_code on create" do
    user = User.create! email: "john@doe.com", password: "password"

    assert_not_nil user.invite_code
  end
end
