import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "greedyField" ]

  connect() {
    window.addEventListener("keydown", this.captureTyping.bind(this))
  }

  captureTyping(e) {
    this.greedyFieldTarget.focus()
  }
}
