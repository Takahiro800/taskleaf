// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import "bootstrap";
import "../stylesheets/application";

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

import "../stylesheets/application";

//= require jquery3
//= require popper
//= require bootstrap-sprockets

document.addEventListener("turbolinks:load", function () {
  document.querySelectorAll(".delete").forEach(function (a) {
    a.addEventListener("ajax:success", function () {
      const td = a.parentNode;
      const tr = td.parentNode;
      tr.style.display = "none";
    });
  });
});
