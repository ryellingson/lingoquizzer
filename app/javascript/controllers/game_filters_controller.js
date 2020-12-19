import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "form" ]

  connect() {
    console.log("welcome to game-filters");
  }

  submit() {
    console.log("form submitted");
    this.formTarget.submit();
  }
}
