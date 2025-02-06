import { BridgeComponent } from "@hotwired/hotwire-native-bridge"

export default class extends BridgeComponent {
  static component = "vibrate"

  connect() {
    super.connect()

    console.info("Vibrate connect()")

    this.send("connect", {}, () => {
      this.bridgeElement.style.background = "#ff0"
    })
  }
}
