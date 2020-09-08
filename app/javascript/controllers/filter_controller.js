import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "language", "difficulty", "category" ]

  connect() {
    this.outputTarget.textContent = 'Hello, Stimulus!'
  }
}
