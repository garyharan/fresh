import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tabbed-navigation"
export default class extends Controller {
  connect() {
    console.log("Hello, Stimulus!", this.element)

    this.tabLinks = this.element.querySelectorAll("a")

    console.log(this.tabLinks)

    if (this.tabLinks.length <= 1) {
      return
    }

    this.activeClasses   = Array.from(this.tabLinks[0].classList)
    this.inactiveClasses = Array.from(this.tabLinks[1].classList)

    this.tabLinks.forEach((link) => {
      link.addEventListener("click", (event) => {
        var tabLink = event.target.closest('a')
        this.showTab(tabLink)
      })
    })
  }

  showTab(tabLink) {
    this.tabLinks.forEach((link) => {
      link.classList.remove(...link.classList)

      if (link === tabLink) {
        this.activeClasses.forEach((className) => {
          link.classList.add(className)
        })
      } else {
        this.inactiveClasses.forEach((className) => {
          link.classList.add(className)
        })
      }
    })
  }
}
