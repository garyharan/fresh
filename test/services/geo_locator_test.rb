require "test_helper"

class GeoLocatorTest < ActiveSupport::TestCase
  test "#find calls geocoder" do
    result = GeoLocator.new(45.498372796415964, -73.43277933544931).find
    assert_equal "Saint-Hubert", result[:city]
    assert_equal "Quebec", result[:state]
    assert_equal "Canada", result[:country]
  end
end
