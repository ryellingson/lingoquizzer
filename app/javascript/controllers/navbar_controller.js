import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "toggle", "nav" ]

  connect() {
    console.log("Hello from the navbar controller");
  }

  showMenu() {
    console.log('inside show menu');
    this.navTarget.classList.toggle('show');
  }
}
