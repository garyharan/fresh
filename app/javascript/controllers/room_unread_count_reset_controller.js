import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="room-unread-count-reset"
export default class extends Controller {
  static targets = [ "count" ]

  reset(e) {
    this.countTarget.innerHTML = ''
  }
}
