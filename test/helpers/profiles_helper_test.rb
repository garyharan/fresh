require "test_helper"

class ProfilesHelperTest < ActionView::TestCase
  test "#imperialize should convert to imperial" do
    assert_equal "5'10\"", imperialize(178)
  end
end
