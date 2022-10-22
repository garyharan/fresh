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
    this.displayFilledValues()
  }

  askLocation(event) {
    event.preventDefault()

    if ('geolocation' in navigator) {
      this.locationFieldTarget.value = "loading..."
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

    this.displayFilledValues()
  }

  displayFilledValues() {
    this.locationFieldTarget.value = this.cityTarget.value + ", " + this.stateTarget.value + ", " + this.countryTarget.value
  }

  explainGeoRequirement() {
    alert("We need location services to allow us to match you with others.")
    this.showButton()
  }

  hideButton() {
    this.locationButtonTarget.style.display = "none"
  }

  showButton() {
    this.locationButtonTarget.style.display = "inline"
  }
}
