import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "frame", "latitude", "longitude"];

  debounceTimeout = null;

  connect() {
    this.inputTarget.addEventListener("keydown", this.onKeyDown.bind(this));
    this.inputTarget.addEventListener("focus", () => {
      if (this.frameTarget.src) {
        this.frameTarget.classList.remove("hidden");
      }
    });
    this.inputTarget.addEventListener("blur", () => {
      this.frameTarget.classList.add("hidden");
    });

    this.frameTarget.addEventListener(
      "turbo:frame-load",
      this.onFrameLoad.bind(this)
    );
  }

  update(event) {
    const query = event.target.value;

    if (this.debounceTimeout) {
      clearTimeout(this.debounceTimeout);
    }

    this.debounceTimeout = setTimeout(() => {
      if (!query || query.length < 3) {
        return;
      }

      const url = new URL(this.frameTarget.dataset.baseUrl);
      url.searchParams.set("query", query);
      this.frameTarget.src = url;
    }, 300);
  }

  onKeyDown(event) {
    const items = this.frameTarget.querySelectorAll("li");
    if (!items || items.length === 0) {
      return;
    }

    if (event.key === "ArrowDown") {
      event.preventDefault();
      this.highlightedIndex = (this.highlightedIndex + 1) % items.length;
      this.updateHighlight(items);
    } else if (event.key === "ArrowUp") {
      event.preventDefault();
      this.highlightedIndex =
        (this.highlightedIndex - 1 + items.length) % items.length;
      this.updateHighlight(items);
    } else if (event.key === "Enter" || event.key === "Tab") {
      event.preventDefault();
      if (this.highlightedIndex >= 0 && this.highlightedIndex < items.length) {
        this.selectItem(items[this.highlightedIndex]);
      }
    }
  }

  selectItem(selectedItem) {
    if (selectedItem) {
      this.inputTarget.value = selectedItem.getAttribute("data-full-address");
      this.latitudeTarget.value = selectedItem.getAttribute("data-latitude");
      this.longitudeTarget.value = selectedItem.getAttribute("data-longitude");
      this.frameTarget.classList.add("hidden");
    }

    const formElements = Array.from(this.inputTarget.form.elements).filter(
      (el) => el.tagName !== "FIELDSET" && !el.disabled
    );
    const currentIndex = formElements.indexOf(this.inputTarget);
    const nextIndex = (currentIndex + 1) % formElements.length;
    formElements[nextIndex].focus();
  }

  onFrameLoad() {
    this.highlightedIndex = -1;

    const items = this.frameTarget.querySelectorAll("li");
    items.forEach((item) => {
      item.addEventListener("mouseover", () => {
        this.highlightedIndex = Array.from(items).indexOf(item);
        this.updateHighlight(items);
      });

      item.addEventListener("mousedown", (event) => {
        event.preventDefault();
        this.selectItem(item);
      });
    });
  }

  updateHighlight(items) {
    items.forEach((item, index) => {
      if (index === this.highlightedIndex) {
        item.classList.add("bg-blue-500", "text-white");
        item.scrollIntoView({ block: "nearest" });
      } else {
        item.classList.remove("bg-blue-500", "text-white");
      }
    });
  }
}
