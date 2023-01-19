import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="distance"
export default class extends Controller {
  static targets = [ "display", "input", "saved", "error" ]

  static values = {
    units: String
  }

  connect() {
    this.inputTarget.addEventListener("input", this.update.bind(this))
    this.inputTarget.addEventListener("change", this.save.bind(this))

    this.update()
  }

  update(event) {
    this.reset()

    this.displayTarget.textContent = this.toHumanReadableDistance(this.inputTarget.value)
  }

  toHumanReadableDistance(distance) {
    if (this.unitsValue == "metric") {
      return `${Math.floor(distance / 10_000)} km`
    } else {
      return `${Math.floor(distance * 0.000062137119224)} miles`
    }
  }

  reset() {
    this.savedTarget.classList.add("hidden")
    this.errorTarget.classList.add("hidden")

    this.savedTarget.classList.add("opacity-0")
    this.errorTarget.classList.add("opacity-0")
  }

  save(event) {
    let data = JSON.stringify({
      "user": {
        "distance": this.inputTarget.value
      }
    });

    fetch(this.element.getAttribute("action"), {
      method: "PATCH",
      credentials: "same-origin",
      headers: {
        "X-CSRF-Token": this.getMetaValue("csrf-token"),
        "Content-Type": "application/json",
      },
      body: data,
    }).then((response) => this.handleResponse(response))

  }

  handleResponse(response) {
    if (response.ok) {
      this.displaySaved()
    } else {
      this.displayError()
    }
  }

  displaySaved() {
    this.savedTarget.classList.remove("hidden")
    this.savedTarget.classList.remove("opacity-0")
  }

  displayError() {
    this.errorTarget.classList.remove("hidden")
    this.errorTarget.classList.remove("opacity-0")
  }

  getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`);
    return element.getAttribute("content");
  }
}
