import { Controller } from "stimulus"

export default class extends Controller {
  static targets = []

  connect() {
    console.log("Welcome to tablegame");
    this.playButtons = document.querySelectorAll(".play-button");
    this.quitButtons = document.querySelectorAll(".quit-button");
    this.replayButton = document.querySelector(".restart");
    this.gameInput = document.querySelector(".game-input");
    this.answers = document.querySelectorAll(".answer");
    this.answerCount = this.answers.length;
    this.backButton = document.querySelector(".shift-button-left");
    this.nextButton = document.querySelector(".shift-button-right");
    this.correctCountShow = document.querySelectorAll(".correct-count");
    this.timeShow = document.querySelector(".timer");
    this.scoreShow = document.querySelectorAll(".score");
    this.url = new URL(window.location.href);
    this.autoplay = this.url.searchParams.get("autoplay");
    this.currentAnswer = this.answers[0];
    this.currentIndex = 0;
    this.correctCountValue = 0;
    this.interval = null;
    this.score = 0;
    // this.listenerAdded = false;
    this.gameData = document.querySelector("#game-data");

    this.gameDataObject = {
      difficulty: this.gameData.dataset.difficulty,
      genre: this.gameData.dataset.genre,
      score: parseInt(this.gameData.dataset.score),
      playTime: parseInt(this.gameData.dataset.playTime),
      category: this.gameData.dataset.category,
      characterType: this.gameData.dataset.characterType,
      perfectPlayUrl: this.gameData.dataset.perfectPlayUrl,
      perfectBadgeUrl: this.gameData.dataset.perfectBadgeUrl
    }

    this.initialTime = this.gameDataObject.playTime;
    this.timeLeft = this.initialTime;

    this.initializeGame();
    this.konamiCode();
  }

  disconnect() {
    clearInterval(this.interval);
    window.removeEventListener('keyup', this.konamiListener);
  }

  konamiCode() {
    this.pressed = [];
    window.addEventListener('keyup', this.konamiListener);
  }

  konamiListener = (e) => {
    const secretCode = 'perfecto'; //change to up up down down left right?
    this.pressed.push(e.key);
    this.pressed.splice(-secretCode.length - 1, this.pressed.length - secretCode.length);
    if (this.pressed.join('').includes(secretCode)) {
      this.correctCountValue = this.answerCount;
      this.endGame();
      this.pressed = [];
    }
  };

  startGame = () => {
    this.interval = setInterval(this.updateTimer, 1000);
    this.playButtons.forEach((button) => button.classList.add("hidden"));
    this.quitButtons.forEach((button) => button.classList.remove("hidden"));
    this.gameInput.parentNode.classList.remove("hidden");
    this.gameInput.addEventListener('input', this.handleInputChange);
    this.gameInput.focus();
    this.currentAnswer.parentNode.classList.add("active-row");
  }

  updateTimer = () => {
    this.timeLeft -= 1;
    const sec = this.timeLeft % 60;
    this.timeShow.innerHTML = `${Math.floor(this.timeLeft / 60)}:${sec < 10 ? "0" + sec : sec}`;
    if (this.timeLeft == 0) { this.endGame() };
  }

  handleInputChange = () => {
    if (Object.values(JSON.parse(this.currentAnswer.dataset.answers)).flat().includes(this.gameInput.value.trim())) {
      if (!this.currentAnswer.classList.contains("correct-answer")) {
        this.currentAnswer.classList.add("correct-answer");
        this.score += this.gameDataObject.score;
        this.scoreShow.forEach(element => element.innerHTML = `${this.score}pts`);
        this.currentAnswer.innerHTML = this.buildAnswerCards(JSON.parse(this.currentAnswer.dataset.answers));
        this.correctCountValue += 1;
      }
      this.gameInput.value = "";
      this.updateCurrentAnswer("next");
      this.correctCountShow.forEach(element => element.innerHTML = `${this.correctCountValue}/${this.answerCount}`);
      if (this.correctCountValue == this.answerCount) { this.endGame() };
      if (this.gameInput.value == null) this.currentAnswer.classList.add("empty-answer");
    }
  }

  buildAnswerCards(answer) {
    const answerKeys = Object.keys(answer);
    let cards = "";
    if (answer.icon_based) {
      if (answerKeys.includes("kana")) {
        cards += `<div class="kana-box">${answer["kana"]}</div>`;
      }
      if (answerKeys.includes("kanji") && answer["kanji"] !== answer["kana"]) {
        cards += `<div class="kanji-box">${answer["kanji"]}</div>`;
      }
      if (answerKeys.includes("romaji")) {
        cards += `<div class="romaji-box">${answer["romaji"]}</div>`;
      }
      if (answerKeys.includes("latin")) {
        cards += `<div>${answer["latin"].join(', ')}</div>`;
      }
    } else {
      cards += `<div>${answer["romaji"]}</div>`;
    }
    return(cards);
  }

  updateCurrentAnswer(shift) {
    if (!this.currentAnswer.innerHTML) {
      this.currentAnswer.classList.add("empty-answer");
    } else {
      this.currentAnswer.classList.remove("empty-answer");
    }
    this.currentAnswer.parentNode.classList.remove("active-row");
    this.gameInput.focus();
    // if shift = "next" add an index else it subtracts an index
    const change = (shift == "next" ? 1 : -1);
    this.currentIndex = (((this.currentIndex + change) % this.answerCount) + this.answerCount) % this.answerCount;
    this.currentAnswer = this.answers[this.currentIndex];
    this.currentAnswer.parentNode.classList.add("active-row");
    // this.currentAnswer.parentNode.scrollIntoView({block: "center", behavior: "smooth"}); Breaks with input ????
    this.currentAnswer.parentNode.scrollIntoView({block: "center"});
  }

  postResults() {
    console.log("posting");
    const postURL = document.querySelector(".game-container").dataset.url;
    fetch(postURL, {
      method: "POST",
      body: JSON.stringify({
        play: {
          score: this.score,
          time: (this.initialTime - this.timeLeft),
          count: this.correctCountValue
        }
      }),
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": Rails.csrfToken(),
      }
    })
    console.log("posted");
  }

  endGame() {
    this.answers.forEach((answer) => {
      if (!answer.innerHTML) {
        answer.classList.add("wrong-answer");
        answer.innerHTML = this.buildAnswerCards(JSON.parse(answer.dataset.answers));
      }
    })
    document.querySelector(".game-stats").classList.remove("hidden");
    clearInterval(this.interval);
    this.score += this.timeLeft;
    this.scoreShow.forEach(element => element.innerHTML = `${this.score}pts`);
    this.displayEndGameModal();
    this.postResults();
  }

  displayEndGameModal() {
    if (this.correctCountValue === this.answerCount) {
      Swal.fire({
        imageUrl: `${this.gameDataObject.perfectPlayUrl}`,
        imageWidth: 200,
        imageHeight: 200,
        imageAlt: 'Perfect Play',
        title: '<u>Perfect Play!</u>',
        html:
          `<div>Time Bonus: ${this.timeLeft}pts</div><br>` +
          `<div>Correct Answers: ${this.correctCountValue}/${this.answerCount}</div><br>` +
          `<div>Score: ${this.score}pts</div>`
      });
    } else {
      Swal.fire({
        icon: 'success',
        title: '<u>Nice Play!</u>',
        html:
          `<div>Time Bonus: ${this.timeLeft}pts</div><br>` +
          `<div>Correct Answers: ${this.correctCountValue}/${this.answerCount}</div><br>` +
          `<div>Score: ${this.score}pts</div>`
      });
    }
    this.playButtons.forEach((button) => button.classList.remove("hidden"));
    this.quitButtons.forEach((button) => button.classList.add("hidden"));
  }

  restartGame = () => {
    if (this.autoplay == "true") {
      window.location.reload();
    } else {
      window.location.replace(window.location.href.split("?")[0] + "?autoplay=true");
    }
  }

  initializeGame() {
    if (this.playButtons.length > 0) {
      this.replayButton.addEventListener('click', this.restartGame);
      this.playButtons.forEach((button) => button.addEventListener('click', this.restartGame));
      this.quitButtons.forEach((button) => button.addEventListener('click', () => this.timeLeft = 1));
      this.nextButton.addEventListener('click', () => this.updateCurrentAnswer("next"));
      this.backButton.addEventListener('click', () => this.updateCurrentAnswer("back"));
    }

    document.addEventListener('keydown', (event) => {
      switch (event.keyCode) {
        // case 37: // left
        // updateCurrentAnswer("back");
        // break;
        case 38: // up
        this.updateCurrentAnswer("back");
        break;
        // case 39: // right
        // updateCurrentAnswer("next");
        // break;
        case 40: // down
        this.updateCurrentAnswer("next");
        break;
      }
    });

    if (this.autoplay == "true") {
      this.startGame();
    }
  }
}
