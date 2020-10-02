import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "output" ]

  connect() {
    this.gameCardOverlays = document.querySelectorAll('.locked-overlay');
    this.unlocked();
  }

  initialize() {

  }

  locked() {
    this.gameCardOverlays.forEach(overlay => {
      overlay.style.display = 'flex';
    })
  }

  unlocked() {
    this.gameCardOverlays.forEach(overlay => {
      overlay.style.display = 'none';
    })
  }
}
