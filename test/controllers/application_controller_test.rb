require "test_helper"

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test "should define a mobile? helper" do
    get root_url, headers: { "User-Agent" => "Hotwire" }
    assert @controller.view_context.mobile?
  end
end
