// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import flatpickr from "flatpickr";
import "jquery-bar-rating";
import { toggleDateInputs } from "./plugins/init_flatpickr";
import { initStarRating } from './plugins/init_star_rating';
import { initAutocomplete } from "./plugins/init_autocomplete"

import { initMapbox } from './plugins/init_mapbox';


// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();

  toggleDateInputs();
  initMapbox();

  initStarRating();
  initAutocomplete();
  // add active to first element with .carousel-indicators li
  const firstIndicator = document.querySelector(".carousel-indicators li");
  if (firstIndicator) firstIndicator.classList.add("active");


  // add active to the first element with .carousel-item
  const firstImage = document.querySelector(".carousel-item");
  if (firstImage) firstImage.classList.add("active");
});
