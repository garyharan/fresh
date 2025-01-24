require "test_helper"

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test "should define a hotwire_native? helper" do
    get root_url, headers: { "User-Agent" => "Hotwire Native" }
    assert @controller.view_context.hotwire_native?
  end
end
