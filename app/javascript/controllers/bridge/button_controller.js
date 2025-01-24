import { BridgeComponent } from "@hotwired/hotwire-native-bridge"

export default class extends BridgeComponent {
  static component = "button"

  connect() {
    super.connect()

    const title = this.bridgeElement.bridgeAttribute("title")
    this.send("connect", {title}, () => {
      this.bridgeElement.click()
    })
  }
}
