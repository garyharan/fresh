require "test_helper"

class GroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:gathino)

    @group = groups(:one)
  end

  test "should get index" do
    get groups_url
    assert_response :success
  end

  test "should get new" do
    get new_group_url
    assert_response :success
  end

  test "should get show" do
    get group_url(@group)
    assert_response :success
  end

  test "should create group" do
    assert_difference("Group.count") do
      post groups_url, params: { group: { name: "New Group" } }
    end

    group = Group.last

    assert_equal "New Group", group.name
    assert_redirected_to group_url(group)
  end

  test "should update group" do
    patch group_url(groups(:one)), params: { group: { name: "New Group Name" } }
    assert_redirected_to group_url(groups(:one))
  end

  test "should destroy group" do
    assert_difference("Group.count", -1) { delete group_url(@group) }
    assert_redirected_to groups_url
  end
end
