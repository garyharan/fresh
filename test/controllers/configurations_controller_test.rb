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

  test "should have new sessions and new users as modals" do
    json_response = JSON.parse(@response.body)

    assert_includes json_response['rules'][0]['patterns'], '/session/new$'
    assert_includes json_response['rules'][0]['patterns'], '/users/new$'

    assert_includes json_response['rules'][0]['properties']['context'], 'modal'
  end
end
