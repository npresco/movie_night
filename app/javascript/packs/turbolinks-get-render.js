import Turbolinks from "turbolinks"

document.addEventListener("turbolinks:load", ()=> {

  const elements = document.querySelectorAll("[data-turbolinks-get-render]");

  elements.forEach(function(element){
    element.addEventListener('ajax:complete',function (event) {
      var xhr = event.detail[0]
      if ((xhr.getResponseHeader('Content-Type') || '').substring(0, 9) === 'text/html') {
        var referrer = window.location.href
        var snapshot = Turbolinks.Snapshot.wrap(xhr.response)
        Turbolinks.controller.cache.put(referrer, snapshot)
        Turbolinks.visit(referrer, { action: 'restore' })
      }
    }, false)
  });
});
