import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="growing-textarea"
export default class extends Controller {
  connect() {
    this.element.addEventListener("keyup", this.handleResize.bind(this))
    this.element.addEventListener("keydown", this.handleSubmission.bind(this))

    this.element.form.addEventListener("turbo:submit-end", this.resetField.bind(this))

    this.originalHeight = this.element.style.height
  }

  handleResize() {
    this.element.style.height = this.element.scrollHeight + "px"
  }

  handleSubmission(event) {
    if (!this.isMobileClient()) {
      if (event.keyCode === 13 && !event.shiftKey) {
        event.preventDefault()
        this.submitForm()
        this.resetField()
      }
    }
  }

  submitForm() {
    this.element.form.requestSubmit()
  }

  resetField() {
    this.element.value = ""
    this.element.style.height = this.originalHeight
  }

  isMobileClient() {
    if (navigator.userAgendData && navigator.userAgentData.mobile) {
      return true
    }

    return /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)
  }
}
