require "test_helper"

class AssessmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    Room.destroy_all
    sign_in profiles(:one).user
  end

  test "should create assessment and render matched partial when reciprocated" do
    Assessment.create!( from_profile: profiles(:two), to_profile: profiles(:one), kind: :liked )

    assert_difference "Room.count", 1 do
      assert_difference "Assessment.count", 1 do
        post profile_assessments_path(profiles(:two), params: { kind: :liked })
      end
    end

    assert_response :success
    assert_match "You matched with #{profiles(:two).display_name}!", @response.body
  end

  test "should create assessment and render index partial when not reciprocated" do
    assert_difference "Assessment.count", 1 do
      post profile_assessments_path(profiles(:two), params: { kind: :liked })
    end

    assert_response :success
    refute_match "You matched with #{profiles(:two).display_name}!", @response.body
  end

  test "should not create room when not reciprocated" do
    assert_no_difference("Room.count") do
      post profile_assessments_path(profiles(:two)), params: { kind: :liked }
    end
  end
end
