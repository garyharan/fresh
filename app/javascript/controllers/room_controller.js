import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="room"
export default class extends Controller {
  static targets = [ "greedyField" ]

  connect() {
    window.onkeydown = (e) => { this.keyDown(e) }
  }

  keyDown(e) {
    this.greedyFieldTarget.focus()
  }
}
