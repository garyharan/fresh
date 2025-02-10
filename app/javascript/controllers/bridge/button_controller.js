import { BridgeComponent } from "@hotwired/hotwire-native-bridge"

export default class extends BridgeComponent {
  static component = "button"

  static values = {
    title: String,
    position: String,
    vibrate: String
  }

  connect() {
    super.connect()

    const title = this.titleValue
    const position = this.positionValue
    const vibrate = this.vibrateValue

    this.send("connect", {title, position, vibrate}, () => {
      this.bridgeElement.click()
    })
  }
}
