import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "topImage", "bottomImage", "settings" ]

  connect() {
    console.log(this.topImageTarget, this.bottomImageTarget);
    this.transitionIn = true;
    const slideDuration = this.settingsTarget.dataset.slideDuration
    const fadeDuration = this.settingsTarget.dataset.fadeDuration
    this.slideUrls = JSON.parse(this.settingsTarget.dataset.slideUrls)
    this.nextIndex = 0
    setInterval(() => {
      this.nextIndex += 1
      this.nextIndex = this.nextIndex % this.slideUrls.length
      const imageUrl = this.slideUrls[this.nextIndex]
      if (imageUrl.match(/^https:\/\/source\.unsplash\.com/)) imageUrl += `&${Math.random()}`;
      this.imageTransition(imageUrl, fadeDuration)
    }, slideDuration)
  }

  imageTransition(imageUrl, fadeDuration = 2000) {
    setTimeout(() => {
      this.topImageTarget.classList.toggle("fade-in")
      this.topImageTarget.classList.toggle("opacity-0")
      this.topImageTarget.classList.toggle("fade-out")
    }, 2000);
    this.transitionIn ? this.topImageTarget.src = imageUrl : this.bottomImageTarget.src = imageUrl;
    this.transitionIn = !this.transitionIn;
  }
}
