import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="room-unread-count-reset"
export default class extends Controller {
  static targets = [ "frame" ]

  reset() {
    this.frameTarget.innerHTML = ''
  }
}
