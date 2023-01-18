import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notification-granter"
export default class extends Controller {
  static targets = [
    "button",
    "deniedInstructions",
    "safari",
    "chrome"
  ]

  connect() {
    console.log(this.buttonTarget)
    this.update()

    this.element.addEventListener("click", this.requestPermission.bind(this))
  }

  requestPermission() {
    Notification.requestPermission().then((permission) => {
      this.update()
    })
  }

  update() {
    console.log("Updating: " + Notification.permission)

    switch (Notification.permission) {
      case "granted":
        this.buttonTarget.classList.add("hidden")
        break;
      case "denied":
        this.showDeniedInstructions()
        break;
      case "default":
        this.buttonTarget.classList.remove("hidden")
        break;
    }
  }

  showDeniedInstructions() {
    this.deniedInstructionsTarget.classList.remove("hidden")

    console.log("This is safari: " + this.isSafari())
    console.log("This is chrome: " + this.isChrome())

    if (this.isSafari()) {
      this.safariTarget.classList.remove("hidden")
    } else if (this.isChrome()) {
      this.chromeTarget.classList.remove("hidden")
    }
  }

  isSafari() {
    return navigator.userAgent.indexOf("Safari") != -1
  }

  isChrome() {
    return navigator.userAgent.indexOf("Chrome") != -1
  }
}
