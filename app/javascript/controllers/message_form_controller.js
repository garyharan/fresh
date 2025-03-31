import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "messageField",
    "submitButton"
  ]

  connect() {
    this.element.addEventListener("submit", this.submit.bind(this));
  }

  submit(event) {
    event.preventDefault();
    this.messageFieldTarget.focus()

    let data = JSON.stringify({
      message: {
        body: this.messageFieldTarget.value
      }
    })
    console.info(data)

    fetch(this.element.action, {
      method: this.element.method,
      headers: {
      "Content-Type": "application/json",
      "X-CSRF-Token": this.#getMetaValue("csrf-token"),
      },
      body: data
    }).then((response) => this.#handleResponse(response));
  }

  #handleResponse(response) {
    if (response.ok) {
      this.messageFieldTarget.value = ''
      this.messageFieldTarget.focus()
    } else {
      console.error(response)
    }
  }

  #getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`);
    return element.getAttribute("content");
  }
}
