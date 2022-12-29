require "test_helper"

class MembershipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:velvet)

    sign_in @user
  end

  test "should get show" do
    @group = groups(:one)
    @membership = memberships(:one)

    get group_membership_url(groups(:one), @membership)
    assert_response :success
  end

  test "should create a membership" do
    @group = groups(:one)

    assert_difference('Membership.count') do
      post group_memberships_url(@group), params: {
        membership: { group_id: @group.id }
      }
    end

    assert @user.profile.groups.include?(@group)
  end
end
