ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

# as per https://rubydoc.info/github/teamcapybara/capybara/master#using-capybara-with-minitest
require 'capybara/rails'
require 'capybara/minitest'
require 'capybara/minitest/spec'

Rails.application.load_seed

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
  # Make `assert_*` methods behave like Minitest assertions
  include Capybara::Minitest::Assertions

  # Reset sessions and driver between tests
  teardown do
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

  def json_response
    @json_response ||= JSON.parse(response.body)
  end

  def sign_in(user)
    post session_url, params: { email_address: user.email_address, password: 'password' }
  end

  def sign_out
    delete session_url
  end
end

use_headless_chrome = ENV['HEADLESS_CHROME']
# use_headless_chrome = true

Capybara.default_driver = if use_headless_chrome
                            :selenium_chrome_headless
                          else
                            :selenium_chrome
                          end

Geocoder.configure(lookup: :test, ip_lookup: :test)
Geocoder::Lookup::Test.set_default_stub(
  [
    {
      'coordinates' => [45.498372796415964, -73.43277933544931],
      'address' => 'Saint-Hubert, Quebec, Canada',
      'city' => 'Saint-Hubert',
      'state' => 'Quebec',
      'state_code' => 'QC',
      'country' => 'Canada',
      'country_code' => 'CA'
    }
  ]
)

Geocoder::Lookup::Test.add_stub(
  'Montreal, Quebec, Canada', [
    {
      "coordinates": [45.5031824, -73.5698065],
      "address": 'Montreal, Quebec, Canada',
      "city": 'Montreal',
      "state": 'Quebec',
      "country": 'Canada',
      "country_code": 'CA'
    }
  ]
)
Geocoder::Lookup::Test.add_stub(
  'Laval, Quebec, Canada', [
    {
      "coordinates": [45.5757802, -73.7530656],
      "address": 'Laval, Quebec, Canada',
      "city": 'Laval',
      "state": 'Quebec',
      "country": 'Canada',
      "country_code": 'CA'
    }
  ]
)
Geocoder::Lookup::Test.add_stub(
  'Mont-Royal', [
    {
      "coordinates": [45.5155642, -73.6425992],
      "address": 'Mount Royal (Mount Royal), QC, Canada',
      "city": 'Mount Royal',
      "state": 'Quebec',
      "country": 'Canada',
      "country_code": 'CA'
    }
  ]
)

Geocoder::Lookup::Test.add_stub(
  'Bar Le Record', [
    {
      "coordinates": [45.543752878037225, -73.62017311633565],
      "address": 'Bar Le Record, 17 Rue Saint-Joseph Est, Montréal, QC H2Y 1K1, Canada',
      "city": 'Montreal',
      "state": 'Quebec',
      "country": 'Canada',
      "country_code": 'CA'
    }
  ]
)

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
