import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "quickview", "overlay" ]

  show(e) {
    // Stop close
    e.stopPropagation()

    // Fetch data about movie
    let movieId = e.currentTarget.getAttribute("data-movie-id")

    fetch(`/movies/${movieId}`).
      then(response => response.text()).
      then(data => {
        this.quickviewTarget.innerHTML = data
      });
    // put it into quickview
    this.quickviewTarget.classList.add("is-active")
  }

  close(e) {
    this.quickviewTarget.classList.remove("is-active")
  }
}
