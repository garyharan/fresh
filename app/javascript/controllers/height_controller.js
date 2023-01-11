import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="height"
export default class extends Controller {
  static targets = [
    'slider',
    'display',
  ]

  static values = {
    units: String
  }

  connect() {
    this.update()
  }

  update() {
    if (this.unitsValue == 'imperial') {
      this.displayTarget.innerText = this.toImperial(this.sliderTarget.value)
    } else {
      this.displayTarget.innerText = this.sliderTarget.value + "cm"
    }
  }

  toImperial(cm) {
    if (cm < 1000) {
      var inches = parseInt(cm * 0.3937)
      return Math.floor(inches / 12) + "'" + (inches % 12) + '"'
    } else {
      return Math.floor(cm / 1000 * 0.621371) + " miles"
    }
  }
}
