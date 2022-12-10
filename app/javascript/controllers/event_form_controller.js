import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="event-form"
export default class extends Controller {
  static targets = [ "start", "end" ]

  connect() {
    this.enforce15MinuteIncrements()
  }

  enforce15MinuteIncrements() {
    this.element.querySelectorAll("select").forEach(function(select) {
      if (select.id.endsWith("_5i")) {
        for (let i = select.options.length; i >= 0; i--) {
          if (i % 15 != 0) {
            select.remove(i)
          }
        }
      }
    })
  }
}
