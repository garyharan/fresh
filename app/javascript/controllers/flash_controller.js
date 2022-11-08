import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.closeButton = this.element.querySelector("button[aria-label='Close']")

    this.closeButton.addEventListener('click', (event) => {
      this.close(event)
    });
  }

  close(event) {
    this.element.classList.add('hidden')
  }
}
