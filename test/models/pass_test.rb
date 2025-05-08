require "test_helper"

class PassTest < ActiveSupport::TestCase
  test "creating a pass destroys any likes for the same profile" do
    gathino = users(:gathino)
    velvet  = users(:velvet)
    eva     = users(:eva)

    gathino_like = Like.create! profile: gathino.profile, user: velvet
    velvet_like  = Like.create! profile: velvet.profile, user: eva
    eva_like     = Like.create! profile: eva.profile, user: gathino

    assert_difference "Pass.count", 1 do
      assert_difference "Like.count", -1 do
        Pass.create! profile: gathino.profile, user: velvet
      end
    end
  end
end
