import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "messageField" ]

  connect() {
    window.addEventListener("keydown", this.#captureTyping.bind(this))
    window.addEventListener("message_controller::message_received", this.#scrollToBottom.bind(this))
  }

  #captureTyping(e) {
    this.messageFieldTarget.focus()
  }

  #scrollToBottom(event) {
    if (this.#isAtBottom()) {
      window.scrollTo(0, (window.innerHeight + document.documentElement.scrollHeight))
    }
  }

  #isAtBottom() {
    return (window.innerHeight + window.scrollY) >= (document.documentElement.scrollHeight - 300);
  }
}
