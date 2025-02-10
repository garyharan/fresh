import { BridgeComponent } from "@hotwired/hotwire-native-bridge"

export default class extends BridgeComponent {
  static component = "liker"

  connect() {
    super.connect()

    window.addEventListener("like", this.like.bind(this))
    window.addEventListener("pass", this.pass.bind(this))

    this.send("connect", {type}, () => {})
  }

  like() {
    this.send("like", {type: "like"})
  }

  pass() {
    this.send("pass", {type: "pass"})
  }
}
