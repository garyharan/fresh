import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "avatar" ]

  connect() {
    this.#applyColour()
    this.#styleBubble()

    if (this.element.getAttribute("data-repress-scroll") !== "true") {
      this.#scrollToMessage()
    }
  }

  #styleBubble() {
    const previousMessage = this.#previousMessage()
    const currentMessage  = this.element

    if (this.#messageIsFromCurrentUser()) {
      this.#createRightTail(this.element)
    } else {
      this.#createLeftTail(this.element)
    }

    if (previousMessage) {
      const previousCreatedAt = new Date(previousMessage.getAttribute("data-created-at").replace(" UTC", "Z"));
      const currentCreatedAt = new Date(currentMessage.getAttribute("data-created-at").replace(" UTC", "Z"));

      const withinOneMinute = ((currentCreatedAt - previousCreatedAt) / 1000) <= 60;

      if (withinOneMinute && this.#previousMessageMatchesMessageUser()) {
        this.#removeTail(previousMessage);
      }
    }
  }

  #applyColour() {
    if (this.#messageIsFromCurrentUser()) {
      this.#setMessageOwnerAsCurrentUserColour()
    } else {
      this.#setMessageOwnerAsOtherUserColour()
    }
  }

  #createRightTail(element) {
    element.classList.remove("rounded-br-3xl")
    element.classList.add("mb-4")
  }

  #createLeftTail(element) {
    element.classList.remove("rounded-bl-3xl")
    element.classList.add("mb-4")
  }

  #removeTail(element) {
    element.classList.add("rounded-br-3xl")
    element.classList.add("rounded-bl-3xl")
    element.classList.remove("mb-4")
  }

  #scrollToMessage() {
    this.element.scrollTo(0, this.element.scrollHeight);
    this.element.scrollIntoView()
  }

  #messageIsFromCurrentUser() {
    return this.element.getAttribute("data-user-id") === this.#currentUserID()
  }

  #previousMessageMatchesMessageUser() {
    return this.#previousMessage() !== null && this.#previousMessage().getAttribute("data-user-id") === this.element.getAttribute('data-user-id')
  }

  #setMessageOwnerAsCurrentUserColour() {
    this.element.classList.add("bg-blue-300", "ml-20")
  }

  #setMessageOwnerAsOtherUserColour() {
    this.element.classList.add("bg-gray-300",  "mr-20")
  }

  #currentUserID() {
    return document.body.getAttribute("data-user-id")
  }

  #previousMessage() {
    return this.element.previousElementSibling
  }
}
