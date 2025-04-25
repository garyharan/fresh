import { BridgeComponent } from "@hotwired/hotwire-native-bridge"

export default class extends BridgeComponent {
  static component = "logo"

  connect() {
    super.connect()

    const position = this.bridgeElement.bridgeAttribute("position")

    this.send("connect", {position}, () => {
      this.bridgeElement.click()
    })
  }
}
