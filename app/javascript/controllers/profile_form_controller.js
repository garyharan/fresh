import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="profile"
export default class extends Controller {
  static targets = ['gender', 'extras']

  connect() {
    var specific = document.createElement("option")
    specific.text = this.letMeBeMoreSpecific()
    this.genderTarget.options.add(specific)
  }

  chooseGender() {
    if (this.genderTarget.value == this.letMeBeMoreSpecific()) {
      this.extrasTarget.style.display = "block"
    } else {
      this.extrasTarget.style.display = "none"
    }
  }

  letMeBeMoreSpecific() {
    return "Let me be more specific"
  }
}
