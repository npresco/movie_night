import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "quickview" ]

  show(e) {
    // Fetch data about movie
    // put it into quickview
    this.quickviewTarget.classList.add("is-active")
  }

  hide(e) {
    this.quickviewTarget.classList.remove("is-active")
  }
}

