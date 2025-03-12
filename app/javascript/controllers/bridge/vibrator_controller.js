import { BridgeComponent } from "@hotwired/hotwire-native-bridge"

export default class extends BridgeComponent {
  static component = "vibrator"

  connect() {
    super.connect()

    window.addEventListener("vibrateLight", this.vibrateLight.bind(this))
    window.addEventListener("vibrateHeavy", this.vibrateHeavy.bind(this))

    this.send("connect", {}, () => {})
  }

  vibrateLight(event) {
    this.send("light", {})
  }

  vibrateHeavy(event) {
    this.send("heavy", {})
  }
}
