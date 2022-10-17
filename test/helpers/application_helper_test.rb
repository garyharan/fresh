require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "should show display name if profile present" do
    user = users(:gathino)
    assert_equal "Gathino", display_name(user)
  end

  test "should default to email if display_name is not created yet" do
    user = users(:velvet)
    assert_equal "velvet@gmail.com", display_name(user)
  end

  test "should have gender choices" do
    assert_equal [
                   "Woman",
                   "Man",
                   "Non-Binary and/or Two Spirit Person",
                   "Let me be more specific"
                 ],
                 gender_choices
  end
end
