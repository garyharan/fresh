require "test_helper"

class PartnershipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:gathino)
    sign_in @user
  end

  test "should create partnership" do
    assert_difference("Partnership.count", 2) do
      post partnerships_url, params: { partnership: { partner_id: profiles(:two).id } }
    end
  end

  test "should destroy partnership" do
    @partnership = @user.profile.partnerships.first

    assert_difference("Partnership.count", -2) do
      delete partnership_url(@partnership)
    end
  end
end
