// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
require("trix");
require("@rails/actiontext");


import Swal from 'sweetalert2/dist/sweetalert2.js';
import 'sweetalert2/src/sweetalert2.scss';
window.Swal = Swal;

import { initInteractiveForm } from "../components/signup_form";

import { initSignUpModal } from "../components/modal";

import { initDropDowns } from "../components/dropdown";

import { initPostCable } from "../channels/post_channel";

document.addEventListener('turbolinks:load', function(e) {
  initSignUpModal();
  initInteractiveForm();
  initDropDowns();
  initPostCable();
});


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import "controllers"
  require("../css/application.scss")
