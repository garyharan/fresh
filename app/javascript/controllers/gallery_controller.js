import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.images = this.element.getElementsByTagName("img")

    this.selectedIndex = 0
    this.display(0)

    this.element.addEventListener("click", (event) => {
      this.slide(event)
    })
  }

  slide(e) {
    const rect = this.element.getBoundingClientRect()
    const clickX = e.clientX - rect.left

    if (clickX > rect.width / 2) {
      this.display(Math.min(this.selectedIndex + 1, this.images.length - 1))
    } else {
      this.display(Math.max(this.selectedIndex - 1, 0))
    }
  }

  display(index) {
    Array.from(this.images).forEach((image, i) => {
      image.style.display = i === index ? "block" : "none"
    })
    this.selectedIndex = index
  }
}
