import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="profile"
export default class extends Controller {
  static targets = [
    'locationField',
    'locationButton',
    'lat',
    'lon',
    'city',
    'state',
    'country',
  ]

  connect() {
    console.log("location controller started")
  }

  askLocation(event) {
    event.preventDefault()

    if ('geolocation' in navigator) {
      this.locationFieldTarget.value = "loading..."

      navigator.geolocation.getCurrentPosition((success) => {
        this.latTarget.value = success.coords.latitude
        this.lonTarget.value = success.coords.longitude

        fetch(this.element.getAttribute("data-location-url-value").concat("?", 'lat=', this.latTarget.value, '&', 'lon=', this.lonTarget.value))
          .then(response => response.json())
          .then(json => this.populateFromGeo(json))
      }, (error) => this.explainGeoRequirement())
    }
  }

  populateFromGeo(json) {
    var city = json["city"]
    var state = json["state"]
    var country = json["country"]

    this.locationFieldTarget.value = city + ", " + state + ", " + country

    this.cityTarget.value = city
    this.stateTarget.value = state
    this.countryTarget.value = country

  }

  explainGeoRequirement() {
    alert("We need location services to allow us to match you with others.")
  }
}
