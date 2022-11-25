import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="card"
export default class extends Controller {
  static targets = [ "title", "content" ]

  connect() {
    this.focusFirstElement()
  }

  focusFirstElement() {
    // this.element.querySelector("input[type=text]").focus()
    if (this.contentTarget.value == '') {
      this.titleTarget.focus()
    } else {
      var end = this.contentTarget.value.length
      this.contentTarget.setSelectionRange(end, end);
      this.contentTarget.focus()
    }
  }

}
