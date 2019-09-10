import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "list" ]

  toggle(e) {
    this.listTarget.classList.toggle("is-hidden")
  }
}
