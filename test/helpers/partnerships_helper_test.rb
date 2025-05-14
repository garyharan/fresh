require "test_helper"

class PartnershipsHelperTest < ActionView::TestCase
  test "marked_as_partner? returns false if there is no current user" do
    Current.stub :user, nil do
      profile = profiles(:one)
      assert_not marked_as_partner?(profile)
    end
  end

  test "marked_as_partner? returns false if the current user's profile has no partnership with the given profile" do
    Current.stub :user, users(:gathino) do
      profile = profiles(:two)
      assert_not marked_as_partner?(profile)
    end
  end

  test "marked_as_partner? returns true if the current user's profile has a partnership with the given profile" do
    Current.stub :user, users(:gathino) do
      profile = profiles(:two)
      Partnership.create!(from_profile: Current.user.profile, to_profile: profile, status: :unconfirmed)
      assert marked_as_partner?(profile)
    end
  end
end
