import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["image"]

  connect() {
    this.startDistance = 0
    this.currentScale = 1
    this.offsetX = 0
    this.offsetY = 0
    this.startX = 0
    this.startY = 0
    this.isDragging = false

    this.imageTarget.addEventListener("touchstart", this.startTouch.bind(this), { passive: false })
    this.imageTarget.addEventListener("touchmove", this.handleMove.bind(this), { passive: false })
    this.imageTarget.addEventListener("touchend", this.endTouch.bind(this))
  }

  startTouch(event) {
    if (event.touches.length === 2) {
      this.startDistance = this.getDistance(event.touches)
      this.isDragging = false
    } else if (event.touches.length === 1) {
      this.isDragging = true
      const touch = event.touches[0]
      this.startX = touch.clientX - this.offsetX
      this.startY = touch.clientY - this.offsetY
    }
  }

  handleMove(event) {
    if (event.touches.length === 2) {
      event.preventDefault()
      const newDistance = this.getDistance(event.touches)
      const scaleChange = newDistance / this.startDistance
      this.imageTarget.style.transform = `translate(${this.offsetX}px, ${this.offsetY}px) scale(${this.currentScale * scaleChange})`
    } else if (event.touches.length === 1 && this.isDragging) {
      event.preventDefault()
      const touch = event.touches[0]
      this.offsetX = touch.clientX - this.startX
      this.offsetY = touch.clientY - this.startY
      this.imageTarget.style.transform = `translate(${this.offsetX}px, ${this.offsetY}px) scale(${this.currentScale})`
    }
  }

  endTouch(event) {
    if (event.touches.length < 2) {
      this.currentScale = parseFloat(this.imageTarget.style.transform.match(/scale\(([^)]+)\)/)?.[1] || 1)
      this.isDragging = false
    }
  }

  getDistance(touches) {
    const [touch1, touch2] = touches
    const dx = touch2.clientX - touch1.clientX
    const dy = touch2.clientY - touch1.clientY
    return Math.sqrt(dx * dx + dy * dy)
  }
}
