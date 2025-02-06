import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.offsetX = 0
    this.offsetY = 0
    this.boundingClientRect = this.element.getBoundingClientRect()

    console.log(this.boundingClientRect)

    this.element.addEventListener("touchstart", this.start.bind(this))
    this.element.addEventListener("touchmove", this.move.bind(this))
  }

  start(event) {
    const touch = event.touches[0];
    this.offsetX = touch.clientX - this.boundingClientRect.left
    this.offsetY = touch.clientY - this.boundingClientRect.top
    this.element.style.position = "absolute"
  }

  move(event) {
    event.preventDefault(); // Prevents page scrolling in Safari
    const touch = event.touches[0];

    const newX = touch.clientX - this.offsetX;
    const newY = touch.clientY - this.offsetY;

    const screenWidth = window.innerWidth;
    const deltaX = newX - this.boundingClientRect.left;
    const rotation = (deltaX / screenWidth) * 30; // Scale to ±15 degrees
    this.element.style.left = `${newX}px`;
    this.element.style.top = `${newY}px`;
    this.element.style.transform = `rotate(${rotation}deg)`;

    const opacity = 1 - (Math.abs(rotation) / 15 / 2);
    this.element.style.opacity = opacity;

    console.log(`moving: ${this.element.style.left}, rotation: ${rotation}deg, opacity: ${opacity}`);
  }
}
