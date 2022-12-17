import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sortable"
export default class extends Controller {
  connect() {
    this.sortable = new Sortable(this.element, {
      draggable: ".draggable",
      onEnd: this.update.bind(this)
    });
  }

  update(event) {
    var id = parseInt(event.item.id.split("_")[1])

    let data = JSON.stringify({
      resource: {
        id: id,
        position: event.newIndex
      }
    });

    fetch(this.element.getAttribute("data-url"), {
      method: "PATCH",
      credentials: "same-origin",
      headers: {
        "X-CSRF-Token": this.getMetaValue("csrf-token"),
        "Content-Type": "application/json",
      },
      body: data,
    });
  }

  getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`);
    return element.getAttribute("content");
  }
}
