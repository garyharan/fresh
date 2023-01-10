import consumer from "./consumer"

consumer.subscriptions.create("UnreadChannel", {
  received(data) {
    const unreadBadge = document.getElementById("unread_badge")

    if (data.unread_count > 0) {
      unreadBadge.classList.remove("hidden")
    } else {
      unreadBadge.classList.add("hidden")
    }
  }
});
