require "test_helper"

class AssessmentTest < ActiveSupport::TestCase
  test "#reciprocated? is true if kind is liked" do
    profile_one = profiles(:one)
    profile_two = profiles(:two)

    assessment_one = Assessment.create!(from_profile: profile_one, to_profile: profile_two, kind: :liked)
    assessment_two = Assessment.create!(from_profile: profile_two, to_profile: profile_one, kind: :liked)

    assert assessment_one.reciprocated?, "should be recriprocated if liked in return"
    assert assessment_two.reciprocated?, "should be recriprocated if liked in return"
  end

  test "#reciprocated? is false if one of the people has not reciprocated" do
    profile_one = profiles(:one)
    profile_two = profiles(:two)

    assessment_one = Assessment.create!(from_profile: profile_one, to_profile: profile_two, kind: :liked)
    assessment_two = Assessment.create!(from_profile: profile_two, to_profile: profile_one, kind: :passed)

    refute assessment_one.reciprocated?, "should be recriprocated if liked in return"
    refute assessment_two.reciprocated?, "should be recriprocated if liked in return"
  end

  test "#reciprocated? returns false if all profiles are not liked" do
    profile_one = profiles(:one)
    profile_two = profiles(:two)

    assessment_one = Assessment.create!(from_profile: profile_one, to_profile: profile_two, kind: :blocked)
    assessment_two = Assessment.create!(from_profile: profile_two, to_profile: profile_one, kind: :passed)

    refute assessment_one.reciprocated?, "should be recriprocated if both liked one another"
    refute assessment_two.reciprocated?, "should be recriprocated if both liked one another"
  end
end
