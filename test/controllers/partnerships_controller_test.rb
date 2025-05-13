require "test_helper"

class PartnershipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:gathino)
    @profile = users(:gathino).profile
    @other_profile = users(:velvet).profile
  end

  test "should create partnership" do
    assert_difference("@profile.partnerships.count", 1) do
      post partnerships_path, params: { profile_id: @other_profile.id }
    end
    assert_redirected_to profile_path(@other_profile)
    follow_redirect!
    assert_match "Partnership created successfully.", response.body
  end

  test "should destroy partnership" do
    partnership = @profile.partnerships.create!(to_profile: @other_profile, status: :unconfirmed)
    assert_difference("@profile.partnerships.count", -1) do
      delete partnership_path(partnership), params: { profile_id: @other_profile.id }
    end
    assert_redirected_to profile_path(@other_profile)
    follow_redirect!
    assert_match "Partnership deleted successfully.", response.body
  end
end
