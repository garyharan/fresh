import consumer from "./consumer"

consumer.subscriptions.create("NotificationChannel", {
  received(data) {
    if (Notification.permission === "granted" && !document.hasFocus()) {
      console.log("Creating notification")

      var notification = new Notification("Message from " + data.sender_name, { body: data.body })

      notification.addEventListener('click', () => {
        location.href = data.url
      })

      window.setTimeout(notification.close.bind(notification), 10 * 1000)
    }
  }
});
