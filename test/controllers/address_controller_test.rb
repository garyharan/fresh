# test/controllers/address_controller_test.rb
require 'test_helper'
require 'mocha/minitest'

class AddressControllerTest < ActionDispatch::IntegrationTest
  def setup
    @mock_geoapify_response = {
      "type" => "FeatureCollection",
      "features" => [
        {
          "type" => "Feature",
          "properties" => {
            "name" => "Le Record bar & vinyles",
            "country" => "Canada",
            "country_code" => "ca",
            "state" => "Quebec",
            "city" => "Montreal",
            "postcode" => "H2R 2N6",
            "street" => "Rue Saint-Hubert",
            "housenumber" => "7622",
            "lon" => -73.6201378,
            "lat" => 45.5437572,
            "formatted" => "Le Record bar & vinyles, 7622 Rue Saint-Hubert, Montreal, QC H2R 2N6, Canada",
            "address_line1" => "Le Record bar & vinyles",
            "address_line2" => "7622 Rue Saint-Hubert, Montreal, QC H2R 2N6, Canada"
          },
          "geometry" => {
            "type" => "Point",
            "coordinates" => [-73.6201378, 45.5437572]
          }
        },
        {
          "type" => "Feature",
          "properties" => {
            "name" => "Sonik Records",
            "country" => "Canada",
            "country_code" => "ca",
            "state" => "Quebec",
            "city" => "Montreal",
            "postcode" => "H2L 4H3",
            "street" => "Rue Berri",
            "housenumber" => "4050",
            "lon" => -73.5751131,
            "lat" => 45.521735,
            "formatted" => "Sonik Records, 4050 Rue Berri, Montreal, QC H2L 4H3, Canada",
            "address_line1" => "Sonik Records",
            "address_line2" => "4050 Rue Berri, Montreal, QC H2L 4H3, Canada"
          },
          "geometry" => {
            "type" => "Point",
            "coordinates" => [-73.5751131, 45.521735]
          }
        }
      ],
      "query" => {
        "text" => "Le Record b",
        "categories" => []
      }
    }

    @empty_response = {
      "type" => "FeatureCollection",
      "features" => [],
      "query" => {
        "text" => "nonexistent",
        "categories" => []
      }
    }
  end

  test "should handle API errors gracefully" do
    sign_in users(:gathino)

    AddressController.any_instance.stubs(:fetch_data).raises(Faraday::Error, "Network error")

    assert_raises(Faraday::Error) do
      get address_completion_path, params: { query: 'test query' }
    end
  end

  test "should verify fetch_data is called with correct query" do
    sign_in users(:gathino)

    AddressController.any_instance.expects(:fetch_data)
      .with('Le Record b')
      .returns(@mock_geoapify_response)

    get address_completion_path, params: { query: 'Le Record b' }

    assert_response :success
  end
end
