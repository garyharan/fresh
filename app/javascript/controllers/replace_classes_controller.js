import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="replace-classes"
export default class extends Controller {
  connect() {
    var classes = this.element.getAttribute("data-replace").split(',')

    window.setTimeout(() => {
      this.element.classList.remove(classes[0])
      this.element.classList.add(classes[1])
    }, 1)
  }
}
