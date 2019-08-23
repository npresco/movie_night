import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "modal_container", "modal_content" ]

  show(e) {
    // Prevent quickview from opening
    e.stopPropagation();

    // Fetch data about movie
    let movieId = e.target.closest(".overlay-box").getAttribute("data-movie-id")

    fetch(`/movie_trailers/${movieId}`).
      then(response => response.text()).
      then(data => {
        this.modal_contentTarget.innerHTML = data
      });

    this.toggle(e)
  }

  toggle(e) {
    let iframe = this.modal_contentTarget.querySelector("iframe")
    if (iframe) {
      iframe.setAttribute("src", "");
    }

    this.modal_containerTarget.classList.toggle("is-active")
  }
}
