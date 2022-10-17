import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="profile"
export default class extends Controller {
  static targets = ['gender', 'extras']

  connect() {
    this.setupSpecifiedGenderLogic()
  }

  chooseGender() {
    this.extrasTarget.style.display = (this.genderTarget.value == this.letMeBeMoreSpecific()) ? "block" :  "none"
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
