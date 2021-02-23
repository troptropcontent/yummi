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
import { initFlatpickr } from "../plugins/flatpickr";
// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
  initFlatpickr();

});

import mapboxgl from 'mapbox-gl';

const profileKey = ENV['MAPBOX_API_KEY'];
const btn = document.querySelector("#submit-button");
const input = document.querySelector("#address");
const results = document.querySelector("#results");


input.addEventListener("keyup", (event) => {
  results.innerHTML = "";
  fetch(`https://api.mapbox.com/geocoding/v5/mapbox.places/${input.value}.json?proximity=2.333333,48.866667&country=FR&access_token=${profileKey}`)
    .then(response => response.json())
    .then((data) => {
      const places = data.features;
      places.forEach((place) => {
        results.insertAdjacentHTML("beforeend", `<li>${place.place_name}</li>`);
      });
      const elements = document.querySelectorAll("li");
      elements.forEach(element => element.addEventListener("click", () => {
        input.value = element.innerText;
        results.innerHTML = "";
      }));
    });
});

