import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets =  ["images", "passButton", "likeButton"]

  connect() {
    this.offsetX = 0
    this.offsetY = 0

    this.boundingClientRect = this.element.getBoundingClientRect()
    this.imagesTarget.addEventListener("touchstart", this.start.bind(this))

    this.imagesTarget.addEventListener("touchmove", this.move.bind(this))
    this.imagesTarget.addEventListener("touchend", this.end.bind(this))
  }

  start(event) {
    const touch = event.touches[0];

    this.offsetX = touch.clientX - this.boundingClientRect.left
    this.offsetY = touch.clientY - this.boundingClientRect.top

  }

  move(event) {
    event.preventDefault(); // Prevents page scrolling
    const touch = event.touches[0];

    const newX = touch.clientX - this.offsetX;

    const screenWidth = window.innerWidth;
    const deltaX = newX - this.boundingClientRect.left;
    const rotation = (deltaX / screenWidth) * 15;
    this.imagesTarget.style.left = `${newX}px`;
    this.imagesTarget.style.transform = `rotate(${rotation}deg)`;

    if (newX > 0) {
      this.likeButtonTarget.style.opacity = 1.0
      this.passButtonTarget.style.opacity = 0.5
      this.likeButtonTarget.style.transform = "scale(" + Math.min(this.percentageToTriggerPoint(newX) + 1 , 1.5) + ")"
      this.passButtonTarget.style.transform = "scale(" + Math.max(0, 1 - this.percentageToTriggerPoint(newX)) + ")"
    } else if (newX < 0) {
      this.likeButtonTarget.style.opacity = 0.5
      this.passButtonTarget.style.opacity = 1.0
      this.likeButtonTarget.style.transform = "scale(" + Math.max(0, 1 - this.percentageToTriggerPoint(newX)) + ")"
      this.passButtonTarget.style.transform = "scale(" + Math.min(this.percentageToTriggerPoint(newX) + 1 , 1.5) + ")"
    }

    if (this.hitTriggerPoint(newX)) {
      window.dispatchEvent(new Event("vibrateLight"))
    }
  }

  end(event) {
    const touch = event.changedTouches[0]
    const newX = touch.clientX - this.offsetX

    if (this.hitTriggerPoint(newX)) {
      window.dispatchEvent(new Event("vibrateHeavy"))
    } else {
      this.reset(event)
    }
  }

  reset(event) {
    this.likeButtonTarget.style.opacity = 1.0
    this.passButtonTarget.style.opacity = 1.0

    this.likeButtonTarget.style.transform = "scale(1)"
    this.passButtonTarget.style.transform = "scale(1)"

    this.imagesTarget.style.transition = "left 0.3s, top 0.3s, transform 0.3s";
    this.imagesTarget.style.position = "relative"
    this.imagesTarget.style.left = "0px"
    this.imagesTarget.style.top = "0px"
    this.imagesTarget.style.transform = "rotate(0deg)";

    setTimeout(() => {
      this.imagesTarget.style.transition = "";
    }, 300);
  }

  hitTriggerPoint(newX) {
    const screenWidth = window.innerWidth
    const triggerPoint = screenWidth / 2.5 // a little less than half a screen
    return Math.abs(newX) > triggerPoint
  }

  percentageToTriggerPoint(newX) {
    const screenWidth = window.innerWidth
    const triggerPoint = screenWidth / 2.5 // a little less than half a screen
    return Math.min(1, Math.abs(newX) / triggerPoint);
  }
}
