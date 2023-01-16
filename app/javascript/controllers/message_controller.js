import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "avatar" ]

  connect() {
    if (this.messageIsFromCurrentUser()) {
      this.setMessageOwnerAsCurrentUser()
    } else {
      this.setMessageOwnerAsOtherUser()
    }

    this.element.classList.add("mt-2")
    this.makeTopBorderRounded()

    this.setBubbleBottom()

    if (this.element.getAttribute("data-respress-scroll") === "false") {
      this.scrollToMessage()
    }
  }

  scrollToMessage() {
    this.element.scrollTo(0, this.element.scrollHeight);
    this.element.scrollIntoView()
  }

  messageIsFromCurrentUser() {
    return this.element.getAttribute("data-user-id") === this.currentUserID()
  }

  previousMessageMatchesMessageUser() {
    return this.previousMessage() !== null && this.previousMessage().getAttribute("data-user-id") === this.element.getAttribute('data-user-id')
  }

  nextMessageMatchesMessageUser() {
    return this.nextMessage() !== null && this.nextMessage().getAttribute("data-user-id") === this.element.getAttribute('data-user-id')
  }

  setMessageOwnerAsCurrentUser() {
    this.element.classList.add("bg-blue-300", "ml-20")
  }

  setMessageOwnerAsOtherUser() {
    this.element.classList.add("bg-gray-300",  "mr-20")
  }

  setBubbleBottom() {
    if (this.messageIsFromCurrentUser()) {
      this.element.classList.add("rounded-bl-xl")
    } else {
      this.element.classList.add("rounded-br-xl")
    }
  }

  makeTopBorderRounded() {
    this.element.classList.add("rounded-t-xl")
  }

  makeBottomBorderRounded() {
    this.element.classList.add("rounded-b-xl")
  }

  currentUserID() {
    return document.body.getAttribute("data-user-id")
  }

  previousMessage() {
    return this.element.previousElementSibling
  }

  nextMessage() {
    return this.element.nextElementSibling
  }
}
