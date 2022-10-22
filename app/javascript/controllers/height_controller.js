import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="height"
export default class extends Controller {
  static targets = [
    'slider',
    'display',
  ]

  connect() {
    this.update()
  }

  update() {
    this.displayTarget.innerText = this.sliderTarget.value + "cm"
  }
}
