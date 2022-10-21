class GeoLocator
  def initialize(lat, lon)
    @lat = lat
    @lon = lon
  end

  def find
    results = Geocoder.search([@lat, @lon])
    location = results.first
    { city: location.city, state: location.state, country: location.country }
  end
end
