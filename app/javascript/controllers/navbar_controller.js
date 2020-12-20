import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "output" ]

  connect() {
    console.log("Hello from the navbar controller");
  }
}

// const showMenu = (toggleId, navId) => {
//   const toggle = document.getElementById(toggleId);
//   const nav = document.getElementById(navId);

//   if (toggle && nav) {
//     toggle.addEventListener('click', () => {
//       nav.classList.toggle('show');
//     })
//   }
// }

// showMenu('nav-toggle', 'nav-menu');
