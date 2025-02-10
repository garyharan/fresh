import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.offsetX = 0
    this.offsetY = 0
    this.boundingClientRect = this.element.getBoundingClientRect()

    console.log(this.boundingClientRect)

    this.element.addEventListener("touchstart", this.start.bind(this))
    this.element.addEventListener("touchmove", this.move.bind(this))
    this.element.addEventListener("touchend", this.end.bind(this))
  }

  start(event) {
    const touch = event.touches[0];
    this.offsetX = touch.clientX - this.boundingClientRect.left
    this.offsetY = touch.clientY - this.boundingClientRect.top
    this.element.style.position = "absolute"
  }

  move(event) {
    event.preventDefault(); // Prevents page scrolling
    const touch = event.touches[0];

    const newX = touch.clientX - this.offsetX;

    const screenWidth = window.innerWidth;
    const deltaX = newX - this.boundingClientRect.left;
    const rotation = (deltaX / screenWidth) * 15;
    this.element.style.left = `${newX}px`;
    this.element.style.transform = `rotate(${rotation}deg)`;
  }

  end(event) {
    const touch = event.changedTouches[0]
    const newX = touch.clientX - this.offsetX
    const screenWidth = window.innerWidth

    const triggerPoint = screenWidth / 2 // if moved more than half a screen
    const hitTriggerPoint = Math.abs(newX) > triggerPoint

    if (hitTriggerPoint) {
      // document.getElementById("debug").innerText = "Triggered!!" + new Date().toISOString()
      console.info("triggered like or pass!")
    } else {
      this.element.style.transition = "left 0.3s, transform 0.3s";
      this.element.style.left = `${this.boundingClientRect.left}px`;
      this.element.style.transform = "rotate(0deg)";
    }

    setTimeout(() => {
      this.element.style.transition = "";
    }, 300);
  }
}
