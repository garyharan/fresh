import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="room"
export default class extends Controller {
  static targets = [ "greedyField", "messages" ]
  static values = { unreadUrl: String }

  connect() {
    document.onvisibilitychange = (e) => { this.manageFocus(e) }
    window.onkeydown = (e) => { this.captureTyping(e) }
  }

  manageFocus(event) {
    if (document.visibilityState === "visible") {
      this.greedyFieldTarget.focus()
      this.pickUpLastMessages()
    }
  }

  pickUpLastMessages() {
    let url = this.unreadUrlValue + "?last_message_id=" + this.messagesTarget.querySelector("div:last-child").getAttribute("data-message-id")

    fetch(url)
      .then(response => response.text())
      .then((html) => { Turbo.renderStreamMessage(html) })
  }

  captureTyping(e) {
    this.greedyFieldTarget.focus()
  }

  getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`);
    return element.getAttribute("content");
  }
}
