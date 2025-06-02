import { BridgeComponent  } from "@hotwired/hotwire-native-bridge"

export default class extends BridgeComponent {
  static component = "title"

  connect() {
    super.connect()

    const text = this.bridgeElement.bridgeAttribute("text")
    this.send("connect", {text})
  }
}
