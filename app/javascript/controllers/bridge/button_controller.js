import { BridgeComponent } from "@hotwired/hotwire-native-bridge"

export default class extends BridgeComponent {
  static component = "button"

  connect() {
    super.connect()

    const title = this.bridgeElement.bridgeAttribute("title")
    const iosImage = this.bridgeElement.bridgeAttribute("ios-image")
    const androidImage = this.bridgeElement.bridgeAttribute("android-image")
    const position = this.bridgeElement.bridgeAttribute("position")
    const vibrate = this.bridgeElement.bridgeAttribute("vibrate")

    this.send("connect", {title, iosImage, androidImage, position, vibrate}, () => {
      this.bridgeElement.click()
    })
  }
}
