import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="location"
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
  }

  askLocation(event) {
    if ('geolocation' in navigator) {
      this.hideButton()

      navigator.geolocation.getCurrentPosition((success) => {
        this.latTarget.value = success.coords.latitude
        this.lonTarget.value = success.coords.longitude

        var params = "".concat("?", 'lat=', this.latTarget.value, '&', 'lon=', this.lonTarget.value)
        var url = this.element.getAttribute("data-location-url-value").concat(params)

        fetch(url)
          .then(response => response.json())
          .then(json => this.populateFromGeo(json))
      }, (error) => this.explainGeoRequirement())
    }
  }

  populateFromGeo(json) {
    this.cityTarget.value = json["city"]
    this.stateTarget.value = json["state"]
    this.countryTarget.value = json["country"]
  }

  explainGeoRequirement() {
    alert("We need location services to allow us to match you with others.")
    this.showButton()
  }

  hideButton() {
    this.locationButtonTarget.classList.add("hidden")
  }

  showButton() {
    this.locationButtonTarget.classList.remove("hidden")
  }
}
