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
end
