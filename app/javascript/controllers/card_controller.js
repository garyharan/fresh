import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="card"
export default class extends Controller {
  static targets = [ "title", "content" ]

  connect() {
    this.focusFirstElement()

    this.contentTarget.addEventListener('keydown', this.handleKeyDown.bind(this));
  }

  focusFirstElement() {
    var end = this.contentTarget.value.length
    this.contentTarget.setSelectionRange(end, end);
    this.contentTarget.focus()
  }

  handleKeyDown(event) {
    if ((event.metaKey || event.ctrlKey) && event.key == "Enter") {
      this.submitForm()
    }
  }

  submitForm() {
    this.element.querySelector("input[type=submit]").click()
  }

}
