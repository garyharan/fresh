import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  connect() {
    this.trigger = this.element.querySelector(".trigger");
    this.target  = this.element.querySelector(".target");

    this.dropdown = new Dropdown(this.target, this.trigger)
  }
}
