import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="carousel"
export default class extends Controller {
  static targets = [ "openButton", "nextButton", "previousButton", "overlay" ]

  connect() {
    console.log("carousel")
    this.photos = this.element.querySelectorAll(".photo_container")

    this.nextButtonTarget.addEventListener("click", this.displayNext.bind(this))
    this.previousButtonTarget.addEventListener("click", this.displayPrevious.bind(this))

    window.addEventListener("keydown", this.handleKeydown.bind(this))

    this.setupThumbnails()
  }

  handleKeydown(event) {
    if (event.key === "ArrowRight") {
      this.displayNext(event)
    } else if (event.key === "ArrowLeft") {
      this.displayPrevious(event)
    } else if (event.key === "Escape") {
      this.close(event)
    }
  }

  setupThumbnails() {
    document.querySelectorAll("img[index]").forEach(thumbnail => {
      console.log(thumbnail.getAttribute("index"))
      thumbnail.addEventListener("click", this.displayPhoto.bind(this, thumbnail.getAttribute("index")))
    });
  }

  displayNext(event) {
    event.preventDefault()
    event.stopPropagation()

    this.displayPhoto((this.index + 1) % this.photos.length)
  }

  displayPrevious(event) {
    event.preventDefault()
    event.stopPropagation()

    this.displayPhoto((this.index - 1))
  }

  open(event) {
    this.overlayTarget.classList.remove("hidden")
  }

  close(event) {
    this.overlayTarget.classList.add("hidden")
  }

  displayPhoto(index) {
    this.open()

    window.scrollTo(0, 0)

    if (index < 0) {
      index = this.photos.length - 1
    }
    this.photos.forEach(photo => photo.classList.add("hidden"))
    this.photos[index].classList.remove("hidden")
    this.index = index
  }
}
