
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "movie" ]

  upvote(e) {
    let movieId = e.target.closest("div.is-flex").getAttribute("data-movie");

    console.log(movieId);
    document.querySelectorAll(`[data-movie='${movieId}'`)[0].innerHTML = ` - <span class="icon is-small has-text-link"><i class="fas fa-thumbs-up"></i></span>`
    document.querySelectorAll(`[data-movie='${movieId}'`)[1].value = 1

    e.target.closest("button").setAttribute("disabled", true);
    e.target.closest("div.is-flex").querySelector("[data-action='click->vote#downvote']").disabled = false
  }

  push(e) {
    let movieId = e.target.closest("div.is-flex").getAttribute("data-movie");

    document.querySelectorAll(`[data-movie='${movieId}'`)[0].innerHTML = ""
    document.querySelectorAll(`[data-movie='${movieId}'`)[1].value = 0

    e.target.closest("div.is-flex").querySelector("[data-action='click->vote#upvote']").disabled = false
    e.target.closest("div.is-flex").querySelector("[data-action='click->vote#downvote']").disabled = false
  }

  downvote(e) {
    let movieId = e.target.closest("div.is-flex").getAttribute("data-movie");

    document.querySelectorAll(`[data-movie='${movieId}'`)[0].innerHTML = ` - <span class="icon is-small has-text-danger"><i class="fas fa-thumbs-down"></i></span>`
    document.querySelectorAll(`[data-movie='${movieId}'`)[1].value = -1

    e.target.closest("button").setAttribute("disabled", true);
    e.target.closest("div.is-flex").querySelector("[data-action='click->vote#upvote']").disabled = false
  }
}
