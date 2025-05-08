require 'test_helper'

class RoomsHelperTest < ActionView::TestCase
  test "room_title excludes current_user and formats names" do
    current_user = users(:gathino)
    room = rooms(:one)
    name_of_other_user = "Velvet"

    assert_equal name_of_other_user, room_title(current_user, room)
  end
end
