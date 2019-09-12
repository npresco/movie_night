import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "rating", "title" ]

  show(e) {
    this.titleTarget.classList.add("is-hidden")
    this.ratingTarget.classList.remove("is-hidden")
  }

  hide(e) {
    this.titleTarget.classList.remove("is-hidden")
    this.ratingTarget.classList.add("is-hidden")
  }
}
