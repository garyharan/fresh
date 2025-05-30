import { BridgeComponent } from "@hotwired/hotwire-native-bridge"
import { BridgeElement } from "@hotwired/hotwire-native-bridge"

export default class extends BridgeComponent {
  static component = "menu"
  static targets = ["item"]

  connect() {
    super.connect()

    this.#addMenuButton()
  }

  disconnect() {
    super.disconnect()
    this.#removeMenuButton()
  }

  #addMenuButton() {
    const items = this.itemTargets.map(target => {
      const element = new BridgeElement(target)
      return {
        title: element.title,
        iosImage: element.bridgeAttribute("ios-image"),
        androidImage: element.bridgeAttribute("android-image"),
      }
    })

    const buttonIosImage = this.element.getAttribute("data-menu-ios-image") || "ellipsis.circle"
    const buttonAndroidImage = this.element.getAttribute("data-menu-android-image") || "more_vert"

    this.send("connect", {items, buttonIosImage, buttonAndroidImage}, message => {
      const item = this.itemTargets[message.data.index]
      new BridgeElement(item).click()
    })
  }

  #removeMenuButton() {
    this.send("disconnect")
  }
}
