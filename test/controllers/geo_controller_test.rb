require "test_helper"

class GeoControllerTest < ActionDispatch::IntegrationTest
  test "#show" do
    sign_in users(:gathino)

    get geo_path, params: { lat: 45.498372796415964, lon: -73.43277933544931 }
    json_response = JSON.parse(response.body)

    assert_equal "Saint-Hubert", json_response["city"]
    assert_equal "Quebec", json_response["state"]
    assert_equal "Canada", json_response["country"]
  end
end
