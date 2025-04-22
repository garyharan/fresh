import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "bubble" ]

  connect() {
    this.#styleBubble()
    if (this.element.getAttribute("data-repress-scroll") == "false") {
      window.dispatchEvent(new Event("message_controller::message_received"))
    }
  }

  #styleBubble() {
    const previousMessage = this.element.previousElementSibling
    const currentMessage  = this.element

    if (previousMessage) {
      const previousCreatedAt = new Date(previousMessage.getAttribute("data-created-at").replace(" UTC", "Z"));
      const currentCreatedAt = new Date(currentMessage.getAttribute("data-created-at").replace(" UTC", "Z"));

      const withinOneMinute = ((currentCreatedAt - previousCreatedAt) / 1000) <= 60;

      if (!withinOneMinute) {
        this.element.classList.remove("border-transparent")
      }
    }
  }
}
