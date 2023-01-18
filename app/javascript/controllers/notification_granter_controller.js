import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notification-granter"
export default class extends Controller {
  static targets = [
    "button",
    "grantedInstructions",
    "deniedInstructions",
    "safari",
    "chrome"
  ]

  connect() {
    this.update()

    this.element.addEventListener("click", this.requestPermission.bind(this))
  }

  requestPermission() {
    Notification.requestPermission().then((permission) => {
      this.update()
    })
  }

  update() {
    switch (Notification.permission) {
      case "granted":
        this.buttonTarget.classList.add("hidden")
        this.grantedInstructionsTarget.classList.remove("hidden")
        this.showBrowserSpecificInstructions()
        break;
      case "denied":
        this.showDeniedInstructions()
        this.showBrowserSpecificInstructions()
        break;
      case "default":
        this.buttonTarget.classList.remove("hidden")
        break;
    }
  }

  showDeniedInstructions() {
    this.deniedInstructionsTarget.classList.remove("hidden")

  }

  showBrowserSpecificInstructions() {
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
