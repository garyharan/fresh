require "test_helper"

class RoomTest < ActiveSupport::TestCase
  test ".room_for(profiles) creates a room for the given profiles" do
    profiles = [profiles(:one), profiles(:two)]

    room = nil

    assert_difference "Room.count", 1 do
      room = Room.find_or_create_by_profiles(profiles)
    end

    assert_equal profiles.sort, room.profiles.sort
  end

  test ".room_for(profiles) returns the correct profile" do
    room1 = Room.find_or_create_by_profiles([profiles(:one), profiles(:two)])
    room2 = Room.find_or_create_by_profiles([profiles(:two), profiles(:three)])
    room3 = Room.find_or_create_by_profiles([profiles(:one), profiles(:three)])

    assert_equal 2, room1.profiles.count
    assert_equal 2, room2.profiles.count
    assert_equal 2, room3.profiles.count

    assert_includes room1.profiles.pluck(:display_name), profiles(:one).display_name
    assert_includes room1.profiles.pluck(:display_name), profiles(:two).display_name

    assert_includes room2.profiles.pluck(:display_name), profiles(:two).display_name
    assert_includes room2.profiles.pluck(:display_name), profiles(:three).display_name

    assert_includes room3.profiles.pluck(:display_name), profiles(:one).display_name
    assert_includes room3.profiles.pluck(:display_name), profiles(:three).display_name


    assert_equal [profiles(:one), profiles(:two)].sort,   room1.profiles.sort
    assert_equal [profiles(:two), profiles(:three)].sort, room2.profiles.sort
    assert_equal [profiles(:one), profiles(:three)].sort, room3.profiles.sort
  end
end
