class Location
  attr_reader :name, :full_address, :address, :latitude, :longitude

  def initialize(result)
    @name = result['properties']['name']
    @full_address = result['properties']['formatted']
    @address = result['properties']['address_line2']
    @latitude = result['properties']['lat']
    @longitude = result['properties']['lon']
  end
end
