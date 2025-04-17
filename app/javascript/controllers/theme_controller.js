import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.#updateTheme()
    this.mediaQuery = window.matchMedia('(prefers-color-scheme: dark)')
    this.mediaQuery.addEventListener('change', this.#updateTheme.bind(this))
  }


  disconnect() {
    this.mediaQuery.removeEventListener('change', this.#updateTheme.bind(this))
  }

  #updateTheme() {
    if (this.#isDarkTheme()) {
      document.documentElement.classList.add("dark")
    } else {
      document.documentElement.classList.remove("dark")
    }
  }

  #isDarkTheme() {
    return window.matchMedia("(prefers-color-scheme: dark)").matches
  }
}
