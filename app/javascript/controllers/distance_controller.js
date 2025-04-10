import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="distance"
export default class extends Controller {
  static targets = [ "display", "input" ]

  static values = {
    units: String
  }

  connect() {
    this.inputTarget.addEventListener("input", this.update.bind(this))

    this.update()
  }

  update(event) {
    this.displayTarget.textContent = this.toHumanReadableDistance(this.inputTarget.value)
  }

  toHumanReadableDistance(distance) {
    if (this.unitsValue == "metric") {
      return `${Math.floor(distance / 10_000)} km`
    } else {
      return `${Math.floor(distance * 0.000062137119224)} miles`
    }
  }
}
