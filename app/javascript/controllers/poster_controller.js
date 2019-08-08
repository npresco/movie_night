import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "overlay" ]

  show(e) {
    this.overlayTarget.classList.remove("is-hidden")
  }

  hide(e) {
    this.overlayTarget.classList.add("is-hidden")
  }
}
