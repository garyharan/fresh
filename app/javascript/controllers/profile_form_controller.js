import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="profile"
export default class extends Controller {
  static targets = ['gender', 'extras', 'specified']

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

  letMeBeMoreSpecific() {
    return "Let me be more specific"
  }
}
