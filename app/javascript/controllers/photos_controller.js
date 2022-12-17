import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="photos"
export default class extends Controller {
  static targets = [ "submitButton", "uploadSection", "spinner" ]

  connect() {
  }

  submit(event) {
    this.submitButtonTarget.click()
    this.uploadSectionTarget.classList.add("hidden")
    this.spinnerTarget.classList.remove("hidden")
  }
}
