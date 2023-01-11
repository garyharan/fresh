import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="settings-form"
export default class extends Controller {
  connect() {
    this.element.querySelectorAll('input').forEach((input) => { input.addEventListener('change', () => { this.submitForm() }) })
  }

  submitForm() {
    this.element.requestSubmit()
  }
}
