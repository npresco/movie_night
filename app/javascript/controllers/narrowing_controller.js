import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = [ "form" ]

  connect() {
    console.log("ok")
  }

  search(e) {
    Rails.fire(this.formTarget, "submit");
  }
}
