import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "replyForm" ]

  connect() {

  }

  showReplyForm(event) {
    event.preventDefault()
    this.replyFormTarget.classList.remove('hidden')
  }
}
