import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="profile"
export default class extends Controller {
  static targets = [
    'gender',
    'extras',
    'specified',
    'locationField',
    'locationButton',
    'lat',
    'lon',
  ]

  connect() {
    this.setupSpecifiedGenderLogic()
  }

  chooseGender() {
    if (this.genderTarget.value == this.letMeBeMoreSpecific()) {
      this.extrasTarget.style.display = "block"
      this.specifiedTarget.focus()
    } else {
      this.extrasTarget.style.display = "none"
    }
  }

  setupSpecifiedGenderLogic() {
    var specific = document.createElement("option")
    specific.text = this.letMeBeMoreSpecific()
    this.genderTarget.options.add(specific)
  }

  askLocation(event) {
    event.preventDefault()

    if ('geolocation' in navigator) {
      navigator.geolocation.getCurrentPosition((position) => {
        this.locationFieldTarget.value = position.coords.latitude + " " + position.coords.longitude
        this.latTarget.value = position.coords.latitude
        this.lonTarget.value = position.coords.longitude
      })
    } else {
      alert("We need location services to allow us to match you with others.")
    }
  }

  letMeBeMoreSpecific() {
    return "Let me be more specific"
  }
}
