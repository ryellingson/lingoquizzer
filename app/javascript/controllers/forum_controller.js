import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "posts" ]

  connect() {
    this.page = 1;
  }

  infiniteScroll() {
    if (this.postsTarget.scrollTop === this.postsTarget.scrollHeight - this.postsTarget.clientHeight) {
      this.page += 1;
      fetch(`${window.location.pathname}?page=${this.page}`, {
        method: "get",
        headers: {
          accept: "application/json"
        }
      }).then(response=>response.json()).then(data=>{
        this.postsTarget.insertAdjacentHTML('beforeend', data.content)
      })
    }
  }
}
