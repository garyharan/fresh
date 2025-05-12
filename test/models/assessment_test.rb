require "test_helper"

class AssessmentTest < ActiveSupport::TestCase
  test "#reciprocated? returns true when the assessments are the same kind" do
    profile_one = profiles(:one)
    profile_two = profiles(:two)

    assessment_one = Assessment.create!(from_profile: profile_one, to_profile: profile_two, kind: :liked)
    assessment_two = Assessment.create!(from_profile: profile_two, to_profile: profile_one, kind: :liked)

    assert assessment_one.reciprocated?, "should be recriprocated if liked in return"
    assert assessment_two.reciprocated?, "should be recriprocated if liked in return"
  end

  test "#reciprocated? returns false if the kinds are different" do
    profile_one = profiles(:one)
    profile_two = profiles(:two)

    assessment_one = Assessment.create!(from_profile: profile_one, to_profile: profile_two, kind: :liked)
    assessment_two = Assessment.create!(from_profile: profile_two, to_profile: profile_one, kind: :passed)

    refute assessment_one.reciprocated?, "should be recriprocated if liked in return"
    refute assessment_two.reciprocated?, "should be recriprocated if liked in return"
  end
end
