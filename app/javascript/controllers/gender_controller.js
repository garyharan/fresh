import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="gender"
export default class extends Controller {
  static targets = [
    'gender',
    'extras',
    'specified'
  ]

  connect() {
    this.addSpecificOption()
    this.displaySpecifiedGenderIfSelected()
  }

  addSpecificOption() {
    var specific = document.createElement("option")
    specific.text = this.letMeBeMoreSpecific()
    this.genderTarget.options.add(specific)
  }

  displaySpecifiedGenderIfSelected() {
    if (this.specifiedTarget.value != "") {
      this.genderTarget.options[this.genderTarget.options.length - 1].selected = true
      this.chooseGender()
    }
  }

  chooseGender() {
    if (this.genderTarget.value == this.letMeBeMoreSpecific()) {
      this.extrasTarget.style.display = "block"
    } else {
      this.specifiedTarget.value = ""
      this.extrasTarget.style.display = "none"
    }
  }

  focusSpecifiedGender() {
    this.specifiedTarget.focus()
  }

  letMeBeMoreSpecific() {
    return "Let me be more specific"
  }
}
