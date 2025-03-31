import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "messageField" ]

  connect() {
    window.addEventListener("keydown", this.captureTyping.bind(this))
  }

  captureTyping(e) {
    this.messageFieldTarget.focus()
  }
}
