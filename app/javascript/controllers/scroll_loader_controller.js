import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    window.addEventListener("turbo:before-stream-render", this.#handleStreams.bind(this))

    window.addEventListener("load",           this.#initialize.bind(this))
    document.addEventListener("turbo:load",   this.#initialize.bind(this))
    document.addEventListener("turbo:render", this.#initialize.bind(this))

  }

  #initialize() {
    this.#scrollToBottom()

    if (!this.initialized) {
      this.#resetScrollLoader()
      this.initialized = true
    }
  }

  #scrollToBottom() {
    console.info("Scroll to bottom")
    window.scrollTo(0, (window.innerHeight + document.documentElement.scrollHeight + 1000))
  }

  #resetScrollLoader() {
    this.button = this.element.querySelector('[data-scroll-loader-target="button"]')
    this.spinner = this.element.querySelector('[data-scroll-loader-target="spinner"]')

    console.info(this.button)
    console.info(this.spinner)

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
          this.spinner.classList.remove("hidden")
        }
      }, {
        rootMargin: "0px"
      });
    });

    this.observer.observe(this.button);
  }

  #handleStreams(event) {
    const defaultAction = event.detail.render

    let that = this

    event.detail.render = function(streamElement) {
      console.info(streamElement)
      if (streamElement.action == "prepend_with_scroll_adjust") {
        let previousScrollHeight = document.documentElement.scrollHeight
        let previousScrollTop = document.documentElement.scrollTop

        streamElement.setAttribute("action", "prepend")
        defaultAction(streamElement)

        const newScrollHeight = document.documentElement.scrollHeight
        const scrollDelta = newScrollHeight - previousScrollHeight
        document.documentElement.scrollTop = previousScrollTop + scrollDelta
        that.#resetScrollLoader()
      } else if (streamElement.action == "replace_with_scroll_adjust") {
        streamElement.setAttribute("action", "replace")
        defaultAction(streamElement)
        that.#resetScrollLoader()
      } else {
        defaultAction(streamElement)
        that.#scrollToBottom()
      }
    }
  }
}
