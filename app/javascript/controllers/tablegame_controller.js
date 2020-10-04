import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = []

  connect() {
    this.playButton = document.querySelector("#play-button");
    this.replayButton = document.querySelector(".restart")
    this.gameInput = document.querySelector(".game-input");
    this.answers = document.querySelectorAll(".answer");
    this.answerCount = this.answers.length
    this.backButton = document.querySelector(".back-button");
    this.nextButton = document.querySelector(".next-button");
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
    console.log(this.correctCountValue, this.answerCount);
    console.log('connected');

  }

  disconnect() {
    clearInterval(this.interval);
    window.removeEventListener('keyup', this.konamiListener);
    console.log('disconnected');
  }

  konamiCode() {
    console.log("!window.listenerAdded", !window.listenerAdded);
    console.log('added listener');
    this.pressed = [];
    window.addEventListener('keyup', this.konamiListener);
  }

  konamiListener = (e) => {
    const secretCode = 'perfecto'; //change to up up down down left right?
    this.pressed.push(e.key);
    this.pressed.splice(-secretCode.length - 1, this.pressed.length - secretCode.length);
    if (this.pressed.join('').includes(secretCode)) {
      console.log('DING DING!');
      this.correctCountValue = this.answerCount;
      console.log(this.correctCountValue, this.answerCount);
      this.endGame();
      this.pressed = [];
    }
    console.log(this.pressed);
  };

  startGame = () => {
    this.interval = setInterval(this.updateTimer, 1000);
    this.playButton.classList.add("hidden");
    this.gameInput.parentNode.classList.remove("hidden");
    this.gameInput.addEventListener('input', this.handleInputChange);
    this.gameInput.focus();
    this.currentAnswer.parentNode.classList.add("active-row");
    console.log(this.correctCountValue, this.answerCount);
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
    const postURL = document.querySelector(".game-container").dataset.url;
    console.log('posting');
    console.log("cc value", this.correctCountValue);
    console.log(this.correctCountValue, this.answerCount);
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
    console.log('posted');
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
    console.log('passed endGame');
  }

  displayEndGameModal() {
    const endGameModal = document.querySelector(".modal-bg");
    const gameStats = document.querySelector(".game-stats-content");
    endGameModal.classList.add("bg-active");
    console.log(this.gameDataObject);
    const perfectPlayDisplay = this.correctCountValue === this.answerCount ?
      `<div class="perfect-play-display"><img src="${this.gameDataObject.perfectPlayUrl}" alt=""/></div>` : ""
    const correctAnswers =
      `<div class="endgame-modal-item">Correct Answers: ${this.correctCountValue}/${this.answerCount}</div>`
    const timeBonus = this.timeLeft > 0 ?
      `<div class="endgame-modal-item">Time Bonus: ${this.timeLeft}pts</div>` : ``
    const scoreDisplay =
      `<div class="endgame-modal-item">Score: ${this.score}pts</div>` //change

    const htmlToRender = perfectPlayDisplay + timeBonus + correctAnswers  + scoreDisplay;

    gameStats.insertAdjacentHTML("afterbegin", htmlToRender)
  }

  restartGame = () => {
    if (autoplay == "true") {
      window.location.reload();
    } else {
      window.location.replace(window.location.href + "?autoplay=true");
    }
  }

  initializeGame() {
    if (this.playButton) {
      this.replayButton.addEventListener('click', this.restartGame);
      this.playButton.addEventListener('click', this.startGame);
      this.nextButton.addEventListener('click', () => this.updateCurrentAnswer("next"));
      this.backButton.addEventListener('click', () => this.updateCurrentAnswer("back"));
    }

    document.onkeydown = function(event) {
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
    }

    if (this.autoplay == "true") {
      this.startGame();
    }
  }
}
