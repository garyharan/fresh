require "test_helper"

class ProfileTest < ActiveSupport::TestCase
  test "liked_by?(profile) returns true or false" do
    profile = profiles(:one)
    like =
      Like.create! profile_id: profile.id,
                   author_profile_id: (profiles(:two).id)

    assert profile.liked_by?(profiles(:two))
    refute profile.liked_by?(profiles(:three))
  end
end
