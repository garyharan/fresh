require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "#age should show appropriate age" do
    assert_equal 17, age(17.years.ago)
    assert_equal 18, age(18.years.ago)
    assert_equal "??", age(nil)
  end
end
