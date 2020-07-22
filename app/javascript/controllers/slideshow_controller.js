import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "topImage", "bottomImage" ]

  connect() {
    console.log(this.topImageTarget, this.bottomImageTarget);
    this.keywords = this.topImageTarget.dataset.keywords
    this.transitionIn = true;
    setInterval(() => this.imageTransition(), 5000)
  }

  imageTransition() {
    const imageUrl = `https://source.unsplash.com/900x900/?${this.keywords}&${Math.random()}`;
    setTimeout(() => {
      this.topImageTarget.classList.toggle("fade-in")
      this.topImageTarget.classList.toggle("opacity-0")
      this.topImageTarget.classList.toggle("fade-out")
    }, 2000);
    this.transitionIn ? this.topImageTarget.src = imageUrl : this.bottomImageTarget.src = imageUrl;
    this.transitionIn = !this.transitionIn;
  }
}
