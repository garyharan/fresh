import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clearable"
// when form submits it will clear all elements with data-clearable="true" attribute
export default class extends Controller {
  connect() {
    this.element.addEventListener('turbo:submit-end', (event) => {
      this.clearElements(event)
    });
  }

  clearElements(event) {
    this.element.querySelectorAll('[data-clearable="true"]').forEach((element) => { element.value = '' })
  }
}
