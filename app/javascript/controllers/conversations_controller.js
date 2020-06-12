import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "" ]

  connect() {
    console.log('Hello, from the conversations controller')
  }
}
