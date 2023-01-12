import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clipboard"
export default class extends Controller {
  static targets = [ "source", "tag" ]

  connect() {
  }

  copy(event) {
    event.preventDefault()
    event.stopPropagation()

    let input        = this.sourceTarget
    let originalText = this.tagTarget.innerText

    input.select()
    input.setSelectionRange(0, input.value.length)
    navigator.clipboard.writeText(input.value)

    window.setTimeout(() => {
      this.tagTarget.innerText = originalText
    }, 3000);

    this.tagTarget.innerText = this.element.getAttribute("data-clipboard-success-content")
  }
}
