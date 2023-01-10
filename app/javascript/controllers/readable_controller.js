import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="read-receipts"
export default class extends Controller {
  connect() {
    console.log("Readable:" + this.isMessageFromAnotherUser() + " " + this.isMessageMarkedAsReadAlready())

    if (this.isMessageFromAnotherUser()) {
      if (!this.isMessageMarkedAsReadAlready()) {
        this.markAsRead()
      }
    }
  }

  markAsRead(event) {
    var messageID = this.element.getAttribute("data-message-id")
    var userID = this.currentUserID()
    console.log("marking message " + messageID + " as read by user " + userID)

    let data = JSON.stringify({
      "message_id": messageID
    });

    fetch(this.element.getAttribute("data-readable-url"), {
      method: "POST",
      credentials: "same-origin",
      headers: {
        "X-CSRF-Token": this.getMetaValue("csrf-token"),
        "Content-Type": "application/json",
      },
      body: data,
    });
  }

  isMessageFromAnotherUser() {
    return this.element.getAttribute("data-user-id") !== this.currentUserID()
  }

  isMessageMarkedAsReadAlready() {
    return this.element.getAttribute("data-readable-readers").split(',').includes(this.currentUserID())
  }

  getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`);
    return element.getAttribute("content");
  }

  currentUserID() {
    return document.body.getAttribute("data-user-id")
  }
}
