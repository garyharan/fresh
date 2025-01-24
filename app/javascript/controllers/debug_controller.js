import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="debug"
export default class extends Controller {
  connect() {
    console.info("debugging")
  }
}
