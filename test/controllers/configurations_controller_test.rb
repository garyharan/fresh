require "test_helper"

class ConfigurationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    get ios_v1_configurations_url
  end

  test "should get ios_v1 and return proper json" do
    assert_nothing_raised do
      JSON.parse(@response.body)
    end
  end
end
