import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "overlay" ]

  show(e) {
    // let backdrop = e.currentTarget.getAttribute("data-movie-backdrop")
    // var css = `html { background-image: linear-gradient(rgba(255, 255, 255, 0.45), rgba(255, 255, 255, 0.45)), url(${backdrop});
    //                   background-repeat: no-repeat;
    //                   background-position: center center;
    //                   background-attachment: fixed;
    //                   background-size: cover;
    //                 }`,
    //   head = document.head || document.getElementsByTjgName('head')[0],
    //   style = document.createElement('style');
    //
    // head.appendChild(style);
    //
    // style.type = 'text/css';
    // if (style.styleSheet){
    //   // This is required for IE8 and below.
    //   style.styleSheet.cssText = css;
    // } else {
    //   style.appendChild(document.createTextNode(css));
    // }
    // document.append

    this.overlayTarget.classList.remove("is-hidden")
  }

  hide(e) {
    this.overlayTarget.classList.add("is-hidden")
  }
}
