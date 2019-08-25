import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "flashContainer", "hiddenFlashContainer", "renderedFlashContainer" ]

  connect() {
    if (this.hasHiddenFlashContainerTarget) {
      this.createAndShowFlash(this.hiddenFlashContainerTarget)
    }
  }

  handleRenderedFlashMessage() {
    if (this.hasRenderedFlashContainerTarget) {
      this.createAndShowFlash(this.renderedFlashContainerTarget)
    }
  }

  createAndShowFlash(messageElement) {
    var div = document.createElement('div');
    div.innerHTML = messageElement.innerHTML.trim();
    let newMessage = div.firstChild

    if (newMessage) {
      setTimeout(() => {
        this.fadeOut(newMessage)
      }, 5000)

      this.flashContainerTarget.appendChild(newMessage)

      // Clear the original container so message won't appear navigating back to page
      this.hiddenFlashContainerTarget.innerHTML = ""
    }
  }

  fadeOut(message) {
    message.remove()
  }

  closeFlash(e) {
    this.fadeOut(e.target.parentNode)
  }
}
