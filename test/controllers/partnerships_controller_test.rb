require "test_helper"

class PartnershipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:gathino)
    sign_in @user
  end

  test "should create partnership" do
    assert_difference("Partnership.count") do
      post partnerships_url, params: { partnership: { partner_id: profiles(:four).id } }
    end

    assert_response :success
  end

  test "should destroy partnership" do
    @partnership = @user.profile.partnerships.first

    assert_difference("Partnership.count", -1) do
      delete partnership_url(@partnership)
    end

    assert_redirected_to partnerships_url
  end
end
