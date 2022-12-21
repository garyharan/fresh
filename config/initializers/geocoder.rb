Geocoder.configure(
  lookup: :geoapify,
  api_key: Rails.application.credentials.geoapify.api_key,
  # lookup: :google,
  # api_key: Rails.application.credentials.google_maps.api_key,
  language: :en,
  units: :km

  # Cache configuration
  cache_options: {
    expiration: nil,
    prefix: 'geocoder:'
  }
)
