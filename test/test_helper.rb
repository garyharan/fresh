ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

Geocoder.configure(lookup: :test, ip_lookup: :test)
Geocoder::Lookup::Test.set_default_stub(
  [
    {
      "coordinates" => [45.498372796415964, -73.43277933544931],
      "address" => "4840 Terrasse de Port-Royal, Saint-Hubert, Quebec",
      "city" => "Saint-Hubert",
      "state" => "Quebec",
      "state_code" => "QC",
      "country" => "Canada",
      "country_code" => "CA"
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

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end
