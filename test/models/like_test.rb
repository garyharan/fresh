require "test_helper"

class LikeTest < ActiveSupport::TestCase
  test "creating a like destroys any passes for the same profile" do
    @gathino = users(:gathino)
    @velvet  = users(:velvet)
    @eva     = users(:eva)

    velvet_pass  = Pass.create! profile: @gathino.profile, user: @velvet
    eva_pass     = Pass.create! profile: @velvet.profile, user: @eva
    gathino_pass = Pass.create! profile: @eva.profile, user: @gathino

    assert_difference "Like.count", 1 do
      assert_difference "Pass.count", -1 do
        Like.create! profile: @gathino.profile, user: @velvet
      end
    end
  end
end
