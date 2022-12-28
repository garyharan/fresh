require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  test 'should not save group without name' do
    group = Group.new user: users(:gathino)

    assert_no_difference 'Group.count' do
      group.save
    end

    refute group.valid?
  end

  test 'generates a slug for the group' do
    group = Group.new name: 'Test Group', user: users(:gathino)

    assert_changes 'Group.count' do
      group.save
    end

    assert group.valid?
    assert_not group.slug.nil?
  end
end

