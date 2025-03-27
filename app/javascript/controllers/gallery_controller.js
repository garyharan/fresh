import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.images = this.element.getElementsByTagName("img")

    if (this.imagesLength != this.images.length) {
      this.setupPageIndicator()
      this.imagesLength = this.images.length
    }

    this.element.addEventListener("click", (event) => {
      this.slide(event)
    })

    this.selectedIndex = 0
    this.display(0)
  }

  disconnect() {
    if (this.pageIndicator) {
      this.pageIndicator.remove()
      this.pageIndicator = null
    }
    this.element.removeEventListener("click", this.slide)
  }

  setupPageIndicator() {
    if (this.images.length == 1) return

    this.pageIndicator = document.createElement("div")
    this.pageIndicator.classList.add("relative", "top-1", "left-0", "z-101", "w-full", "flex", "justify-center")

    Array.from(this.images).forEach((image) => {
      const div = document.createElement("div")
      div.classList.add("bg-slate-100", "h-1", "z-100", "mx-1", "flex-grow", "opacity-50", "rounded-full", "border", "border-slate-300")
      this.pageIndicator.appendChild(div)
    })

    this.element.appendChild(this.pageIndicator)
  }

  slide(e) {
    const rect = this.element.getBoundingClientRect()
    const clickX = e.clientX - rect.left

    if (clickX > rect.width / 2) {
      this.display(Math.min(this.selectedIndex + 1, this.images.length - 1))
    } else {
      this.display(Math.max(this.selectedIndex - 1, 0))
    }

    window.dispatchEvent(new Event("vibrateLight"))
  }

  display(index) {
    Array.from(this.images).forEach((image, i) => {
      image.style.display = i === index ? "block" : "none"
    })

    Array.from(this.pageIndicator.children).forEach((indicator, i) => {
      if (i === index) {
        indicator.classList.remove("bg-slate-500")
        indicator.classList.add("bg-slate-100")
      } else {
        indicator.classList.remove("bg-slate-100")
        indicator.classList.add("bg-slate-500")
      }
    })

    this.selectedIndex = index
  }
}
