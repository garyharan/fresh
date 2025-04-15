import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "title", "content" ]

  connect() {
    this.element.addEventListener("submit", (event) => this.#submitedForm(event))
    this.titleTarget.addEventListener("change", (event) => this.#changedPrompt(event))
  }

  #changedPrompt(event) {
    window.dispatchEvent(new Event("vibrateLight"))
  }

  #submitedForm(event) {
    window.dispatchEvent(new Event("vibrateHeavy"))
  }
}
