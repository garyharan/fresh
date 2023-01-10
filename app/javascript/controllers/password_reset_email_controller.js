import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="password-reset-email"
export default class extends Controller {
  static targets = [ "email", "link" ]

  connect() {
    console.log("Connected to password-reset-email controller")
    console.log(this.emailTarget)
    console.log(this.linkTarget)

    this.emailTarget.addEventListener("input", this.updateLink.bind(this))

    this.originalURL = this.linkTarget.href
  }

  updateLink() {
    var email = this.emailTarget.value
    this.linkTarget.href = this.originalURL + "?user[email]=" + email
  }
}
