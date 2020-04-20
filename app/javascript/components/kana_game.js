const initGame = () => {
  const playButton = document.querySelector(".play-button");
  const gameInput = document.querySelector(".game-input");
  const answers = document.querySelectorAll(".answer");
  const backButton = document.querySelector(".back-button");
  const nextButton = document.querySelector(".next-button");
  const correctCountShow = document.querySelector(".correct-count");
  const timeShow = document.querySelector(".timer");

  let currentAnswer = answers[0];
  let currentIndex = 0;
  let correctCountValue = 0;
  let timeLeft = 120;
  let interval;

  const startGame = () => {
    interval = setInterval(updateTimer, 1000);
    playButton.classList.add("hidden");
    gameInput.parentNode.classList.remove("hidden");
    gameInput.addEventListener('input', handleInputChange);
    currentAnswer.parentNode.classList.add("active-row");
  }

  const updateTimer = () => {
    timeLeft -= 1;
    const sec = timeLeft % 60;
    console.log(timeLeft);
    timeShow.innerHTML = `${Math.floor(timeLeft / 60)}:${sec < 10 ? "0" + sec : sec}`;
    if (timeLeft == 0) { endGame() };
  }

  const handleInputChange = () => {
    if (gameInput.value === currentAnswer.dataset.answer) {
      gameInput.value = "";
      currentAnswer.innerHTML = currentAnswer.dataset.answer;
      updateCurrentAnswer("next");
      correctCountValue += 1;
      correctCountShow.innerHTML = `<p>${correctCountValue}/46</p>`;
    if (correctCountValue == 46) { endGame() };
    }
  }

  const updateCurrentAnswer = (shift) => {
    currentAnswer.parentNode.classList.remove("active-row");
    // if shift = "next" add an index else it subtracts an index
    const change = (shift == "next" ? 1 : -1);
    currentIndex = (((currentIndex + change) % 46) + 46) % 46;
    currentAnswer = answers[currentIndex];
    currentAnswer.parentNode.classList.add("active-row");
  }

  const endGame = () => {
    document.querySelector(".game-status").classList.remove("hidden");
    clearInterval(interval);
  }

  playButton.addEventListener('click', startGame);
  nextButton.addEventListener('click', () => updateCurrentAnswer("next"));
  backButton.addEventListener('click', () => updateCurrentAnswer("back"));
}

export { initGame }

// make an array with all the all the question answers
// set the current answer as the first answer
// set the current index as 0
// add an event listener to the game input that listens to a change in the value
// check if the value is the same as the current answer, if it is we empty the input and put answer in cell
// update our current index and current answer
// add active row to next cell
// post results to db


// timer
// score
// kana count
