import { Controller } from "stimulus"
// import bulmaCalendar from "bulma-extensions/bulma-calendar/dist/js/bulma-calendar.js";

export default class extends Controller {
    static targets = []

  connect() {
    // bulmaCalendar.attach('[type="date"]', { "type": "datetime", "color": "info", "dateFormat": "YYYY/MM/DD" });
  }
}

