class AddressController < ApplicationController
  def show
    @locations = get_locations(params[:query])
  end

  private

  def get_locations(query)
    return unless query.present? && query.length >= 4

    data = get_data(query)

    return [] unless data['features'].present?

    data['features'].map { |result| Location.new(result) }
  end

  def get_data(query)
    cache_key = "geoapify-autocomplete:#{query.downcase}:#{user_location_cache_key}_v1"
    Rails.cache.fetch(cache_key, expires_in: 24.hours) do
      fetch_data(query)
    end
  end

  def fetch_data(query)
    response = Faraday.get(
      'https://api.geoapify.com/v1/geocode/autocomplete', {
        text: query,
        apiKey: Rails.application.credentials.geoapify.api_key,
        bias: "proximity:#{Current.user.profile.longitude},#{Current.user.profile.latitude}"
      }
    )

    JSON.parse(response.body)
  end

  def user_location_cache_key
    "#{Current.user.profile.longitude.round(2)}:#{Current.user.profile.latitude.round(2)}"
  end
end
