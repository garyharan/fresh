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

  test "#gender_choice should show default choices" do
    assert_equal ["Woman", "Man", "Non-Binary and/or Two Spirit Person"],
                 gender_choices
  end

  test "#age should show appropriate age" do
    assert_equal 17, age(17.years.ago)
    assert_equal 18, age(18.years.ago)
  end
end
