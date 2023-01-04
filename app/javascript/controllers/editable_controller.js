import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="editable"
export default class extends Controller {
  connect() {
    console.log("Hello, Stimulus!", this.element)
    
  }
}
