import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = []

  connect() {
    console.log("hello from tableGame in Stimulus")
    const playButton = document.querySelector(".btn-primary");
    const replayButton = document.querySelector(".restart")
    const gameInput = document.querySelector(".game-input");
    const answers = document.querySelectorAll(".answer");
    const answerCount = answers.length
    const backButton = document.querySelector(".back-button");
    const nextButton = document.querySelector(".next-button");
    const correctCountShow = document.querySelectorAll(".correct-count");
    const timeShow = document.querySelector(".timer");
    const scoreShow = document.querySelectorAll(".score");
    const endGameModal = document.querySelector(".modal-bg");
    const gameStats = document.querySelector(".game-stats-content");
    const url_string = window.location.href;
    const url = new URL(url_string);
    const autoplay = url.searchParams.get("autoplay");

    const gameData = document.querySelector("#game-data");

    const gameDataObject = {
      difficulty: gameData.dataset.difficulty,
      genre: gameData.dataset.genre,
      score: parseInt(gameData.dataset.score),
      playTime: gameData.dataset.playTime,
      category: gameData.dataset.category,
      characterType: gameData.dataset.characterType
    }

    // const kanaCount = 46;
    let currentAnswer = answers[0];
    let currentIndex = 0;
    let correctCountValue = 0;
    const initialTime = gameDataObject.playTime;
    // const initialTime = 10;
    let timeLeft = initialTime;
    let interval;
    let score = 0;



    const startGame = () => {
      interval = setInterval(updateTimer, 1000);
      playButton.classList.add("hidden");
      gameInput.parentNode.classList.remove("hidden");
      gameInput.addEventListener('input', handleInputChange);
      gameInput.focus();
      currentAnswer.parentNode.classList.add("active-row");
    }

    const updateTimer = () => {
      timeLeft -= 1;
      const sec = timeLeft % 60;
      timeShow.innerHTML = `${Math.floor(timeLeft / 60)}:${sec < 10 ? "0" + sec : sec}`;
      if (timeLeft == 0) { endGame() };
    }

    const handleInputChange = () => {
      if (Object.values(JSON.parse(currentAnswer.dataset.answers)).includes(gameInput.value.trim())) {
        if (!currentAnswer.classList.contains("correct-answer")) {
          currentAnswer.classList.add("correct-answer");
          score += gameDataObject.score;
          console.log("score", score, scoreShow);
          scoreShow.forEach(element => element.innerHTML = `${score}pts`);
          currentAnswer.innerHTML = buildAnswerCards(JSON.parse(currentAnswer.dataset.answers));
        }
        gameInput.value = "";
        updateCurrentAnswer("next");
        correctCountValue += 1;
        correctCountShow.forEach(element => element.innerHTML = `${correctCountValue}/${answerCount}`);
        if (correctCountValue == answerCount) { endGame() };
        if (gameInput.value == null) currentAnswer.classList.add("empty-answer");
      }
    }

    const buildAnswerCards = (answer) => {
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
      } else {
        cards += `<div>${answer["romaji"]}</div>`;
      }
      return(cards);
    }

    const updateCurrentAnswer = (shift) => {
      if (!currentAnswer.innerHTML) {
        currentAnswer.classList.add("empty-answer");
      } else {
        currentAnswer.classList.remove("empty-answer");
      }
      currentAnswer.parentNode.classList.remove("active-row");
      gameInput.focus();
      // if shift = "next" add an index else it subtracts an index
      const change = (shift == "next" ? 1 : -1);
      currentIndex = (((currentIndex + change) % answerCount) + answerCount) % answerCount;
      currentAnswer = answers[currentIndex];
      currentAnswer.parentNode.classList.add("active-row");
      // currentAnswer.parentNode.scrollIntoView({block: "center", behavior: "smooth"}); Breaks with input ????
      currentAnswer.parentNode.scrollIntoView({block: "center"});
    }

    const postResults = () => {
      const postURL = document.querySelector(".game-container").dataset.url;
      fetch(postURL, {
        method: "POST",
        body: JSON.stringify({
          play: {
            score: score,
            time: (initialTime - timeLeft),
            count: correctCountValue
          }
        }),
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": Rails.csrfToken(),
        }
      })
    }

    const endGame = () => {
      answers.forEach((answer) => {
        if (!answer.innerHTML) {
          answer.classList.add("wrong-answer");
          answer.innerHTML = buildAnswerCards(JSON.parse(answer.dataset.answers));
        }
      })
      document.querySelector(".game-stats").classList.remove("hidden");
      clearInterval(interval);
      score += timeLeft;
      scoreShow.forEach(element => element.innerHTML = `${score}pts`);
      displayEndGameModal();
      postResults();
    }

    const displayEndGameModal = () => {
      endGameModal.classList.add("bg-active");
      const perfectPlayDisplay = correctCountValue === answerCount ?
        `<div class="perfect-play-display"><%= image_tag 'perfect_play.svg' %></div>` : ""
      const correctAnswers =
        `<div class="endgame-modal-item">Correct Answers: ${correctCountValue}/${answerCount}</div>`
      const timeBonus = timeLeft > 0 ?
        `<div class="endgame-modal-item">Time Bonus: ${timeLeft}pts</div>` : ``
      const scoreDisplay =
        `<div class="endgame-modal-item">Score: ${score}pts</div>`

      const htmlToRender = perfectPlayDisplay + timeBonus + correctAnswers  + scoreDisplay;

      gameStats.insertAdjacentHTML("afterbegin", htmlToRender)
    }

    const restartGame = () => {
      if (autoplay == "true") {
        window.location.reload();
      } else {
        window.location.replace(window.location.href + "?autoplay=true");
      }
    }

    if (playButton) {
      replayButton.addEventListener('click', restartGame);
      playButton.addEventListener('click', startGame);
      nextButton.addEventListener('click', () => updateCurrentAnswer("next"));
      backButton.addEventListener('click', () => updateCurrentAnswer("back"));
    }

    document.onkeydown = function(event) {
      switch (event.keyCode) {
        case 37: // left
        updateCurrentAnswer("back");
        break;
        case 38: // up
        updateCurrentAnswer("back");
        break;
        case 39: // right
        updateCurrentAnswer("next");
        break;
        case 40: // down
        updateCurrentAnswer("next");
        break;
      }
    }

    if (autoplay == "true") {
      startGame();
    }
  }
}
