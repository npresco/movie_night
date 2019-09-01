document.addEventListener("turbolinks:load", ()=> {
  let video = document.querySelector("video")
  if (video) {
    video.playbackRate = 0.1;
  }
});
