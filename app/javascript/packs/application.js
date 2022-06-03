// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("bootstrap/dist/js/bootstrap")

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import displayChart from "../channels/line_chart"
import Chart from "chart.js/auto"
import "bootstrap"
import "chartkick/chart.js"

Rails.start()
Turbolinks.start()
ActiveStorage.start()
document.addEventListener('turbolinks:load', () => {displayChart()})

// Add event to the connect wallet
const wallet = document.querySelector(".connect");
wallet.addEventListener("click", (event) => {
  console.log(event);
  console.log(event.currentTarget);
});


import "controllers"
