import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "button",
    "spinner"
  ]

  connect() {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          this.#loadMoreMessages();
        }
      }, {
        rootMargin: "0px"
      });
    });

    observer.observe(this.spinnerTarget);
  }

  #loadMoreMessages() {
    this.#showSpinner()
    this.#loadMore()
    this.#hideButton()
  }

  #loadMore() {
    this.buttonTarget.click()
  }

  #hideButton() {
    this.buttonTarget.classList.add("invisible")
  }

  #showSpinner() {
    this.spinnerTarget.classList.remove("invisible")
  }
}
