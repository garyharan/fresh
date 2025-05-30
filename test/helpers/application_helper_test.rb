require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "#hotwire_native_title should return appropriate titles" do
    assert_equal "‎ ", hotwire_native_title("no_title")
    assert_equal "Fresh Dating", hotwire_native_title("")
    assert_equal "Custom Title", hotwire_native_title("Custom Title")
  end

  test "#age should show appropriate age" do
    assert_equal 17, age(17.years.ago)
    assert_equal 18, age(18.years.ago)
    assert_equal "??", age(nil)
  end
end
