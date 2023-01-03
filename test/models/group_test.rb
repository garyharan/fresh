require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  setup do
    @user = users(:gathino)
  end


  test 'should not save group without name' do
    group = Group.new user: @user

    assert_no_difference 'Group.count' do
      group.save
    end

    refute group.valid?
  end

  test 'generates a slug for the group' do
    group = Group.new name: 'Test Group', description: 'Test group is a test group', user: @user

    assert_changes 'Group.count' do
      group.save
    end

    assert group.valid?
    assert_not group.slug.nil?
  end
end

