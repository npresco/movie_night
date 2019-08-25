import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "message" ]

  // Fires custom event so that turbolinks + stimulus will desplay flashes
  // The stimulus flash_controller is listening for this event and will add the message
  // to the flash element on page
  connect() {
    const event = document.createEvent("CustomEvent")
    event.initCustomEvent("messageConnected", true, true, null)
    this.element.dispatchEvent(event)
  }

// TO append to ajax flash
// <div data-controller="rendered-flash-message"
//      data-target="flash.renderedFlashContainer"
//      class="is-hidden">
//   <%= render partial: "shared/flash" %>
// </div>
}

