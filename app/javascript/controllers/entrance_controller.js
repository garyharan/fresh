import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="entrance"
export default class extends Controller {
  connect() {
    this.element.style.opacity = 1
  }
}
