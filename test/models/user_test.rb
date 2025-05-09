require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @profile_one   = profiles(:one)
    @profile_two   = profiles(:two)

    @assessment_one = Assessment.create!(from_profile: @profile_one, to_profile: @profile_two, kind: :liked)
    @assessment_two = Assessment.create!(from_profile: @profile_two, to_profile: @profile_one, kind: :passed)
  end

  test ".liked_profiles should return liked profiles" do
    assert_includes @profile_one.user.liked_profiles, @profile_two
    refute_includes @profile_two.user.liked_profiles, @profile_one
  end

  test ".passed_profiles should return passed profiles" do
    assert_includes @profile_two.user.passed_profiles, @profile_one
    refute_includes @profile_one.user.passed_profiles, @profile_two
  end
end
