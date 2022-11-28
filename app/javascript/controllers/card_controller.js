import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="card"
export default class extends Controller {
  static targets = [ "title", "content" ]

  connect() {
    this.focusFirstElement()
  }

  focusFirstElement() {
    var end = this.contentTarget.value.length
    this.contentTarget.setSelectionRange(end, end);
    this.contentTarget.focus()
  }

}
