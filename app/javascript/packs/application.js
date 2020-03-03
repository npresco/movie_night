// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("chartkick")
require("chart.js")

// import "@fortawesome/fontawesome-free/css/all.css";
import "@fortawesome/fontawesome-free/css/all.css";
import "../stylesheets/application.scss"

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
// const fonts = require.context('../fonts', true)
const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

import "controllers"
import "./turbolinks-get-render"
import "./turbolinks-scroll"
import "./burger-show-hide"
import "./video-playback-speed"

// TODO Flatpickr Stimulus setup
import { Application } from "stimulus";
// import Flatpickr
import Flatpickr from "stimulus-flatpickr";

import { definitionsFromContext } from "stimulus/webpack-helpers";
const application = Application.start();
// const context = require.context("../controllers", true, /\.js$/);
// application.load(definitionsFromContext(context));

// Manually register Flatpickr as a stimulus controller
application.register("flatpickr", Flatpickr);


// TODO Put in quickview js file
import { bulmaQuickview } from "bulma-extensions/dist/js/bulma-extensions.js";

document.addEventListener("turbolinks:load", ()=> {
  var quickviews = bulmaQuickview.attach(); 
})
