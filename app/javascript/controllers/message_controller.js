import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "bubble" ]

  connect() {
    this.currentUserId = document.body.getAttribute("data-user-id")
    this.#styleBubbleBackground()
    this.#styleSpacers()
  }

  #styleBubbleBackground() {
    if (this.currentUserId == this.element.getAttribute("data-user-id")) {
      this.bubbleTarget.classList.add("bg-blue-300")
      this.bubbleTarget.classList.add("ml-20")
    } else {
      this.bubbleTarget.classList.add("bg-gray-300")
      this.bubbleTarget.classList.add("mr-20")
    }
  }

  #styleSpacers() {
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
