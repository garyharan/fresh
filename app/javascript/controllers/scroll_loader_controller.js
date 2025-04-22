import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    window.addEventListener("reset_scroll_loader", this.#resetScrollLoader.bind(this))
    window.addEventListener("turbo:before-stream-render", this.#handlePrependWithAdjustScroll.bind(this))

    this.#resetScrollLoader()
  }

  #resetScrollLoader() {
    this.button = this.element.querySelector('[data-scroll-loader-target="button"]')
    this.spinner = this.element.querySelector('[data-scroll-loader-target="spinner"]')

    if (this.button && this.spinner) {
      this.#startObservingButton()
    }
  }

  #startObservingButton() {
    this.observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          this.observer.unobserve(this.button)
          this.button.click()
          this.button.remove()
          this.spinner.classList.remove("invisible")
        }
      }, {
        rootMargin: "0px"
      });
    });

    this.observer.observe(this.button);
  }

  #handlePrependWithAdjustScroll(event) {
    const defaultAction = event.detail.render

    event.detail.render = function(streamElement) {
      if (streamElement.action == "prepend_with_scroll_adjust") {
        // let previousScrollHeight = document.documentElement.scrollHeight
        // let previousScrollTop = document.documentElement.scrollTop

        streamElement.setAttribute("action", "prepend")
        defaultAction(streamElement)

        // const newScrollHeight = document.documentElement.scrollHeight
        // const scrollDelta = newScrollHeight - previousScrollHeight
        // document.documentElement.scrollTop = previousScrollTop + scrollDelta
      } else if (streamElement.action == "replace_with_scroll_adjust") {
        streamElement.setAttribute("action", "replace")
        defaultAction(streamElement)
        window.dispatchEvent(new Event("reset_scroll_loader"))
      } else {
        defaultAction(streamElement)
      }
    }
  }
}
