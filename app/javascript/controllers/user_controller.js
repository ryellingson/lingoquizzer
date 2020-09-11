import { Controller } from "stimulus"

export default class extends Controller {
  static targets = []

  connect() {
    console.log('Hello, user!');
  }

  drag() {
    const slider = document.querySelector('.plays-cards');
    let isDown = false;
    let startX;
    let scrollLeft;

    slider.addEventListener('mousedown', (e) => {
      console.log('click');
      isDown = true;
      slider.classList.add('plays-cards-active');
      startX = e.pageX - slider.offsetLeft;
      scrollLeft = slider.scrollLeft;
    });

    slider.addEventListener('mouseleave', () => {
      isDown = false;
      slider.classList.remove('plays-cards-active');
    });

    slider.addEventListener('mouseup', () => {
      isDown = false;
      slider.classList.remove('plays-cards-active');
    });

    slider.addEventListener('mousemove', (e) => {
      if (!isDown) return;  // stop the fn from running
      e.preventDefault();
      const x = e.pageX - slider.offsetLeft;
      const walk = (x - startX) * 3;
      slider.scrollLeft = scrollLeft - walk;
    });
  }
}
