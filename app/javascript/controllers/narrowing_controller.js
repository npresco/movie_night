import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = [ "form" ]

  search(e) {
    // Rails.fire(this.formTarget, "submit");
  }
}
