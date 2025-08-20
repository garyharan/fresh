require "test_helper"

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test "should define a hotwire_native? helper" do
    get root_url, headers: { "User-Agent" => "Hotwire Native" }
    assert @controller.view_context.hotwire_native?
  end

  test "should set locale from params" do
    get root_url(locale: "fr")
    assert_equal :fr, I18n.locale
  end

  test "should set locale from Accept-Language header" do
    get root_url, headers: { "Accept-Language" => "fr,en;q=0.9" }
    assert_equal :fr, I18n.locale
  end

  test "should fallback to English requested locale by param if unsupported" do
    get root_url(locale: "cn")
    assert_equal I18n.default_locale, I18n.locale
  end

  test "should fallback to English if Accept-Language header is unsupported" do
    get root_url, headers: { "Accept-Language" => "es" }
    assert_equal I18n.default_locale, I18n.locale
  end
end
