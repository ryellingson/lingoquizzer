const initGame = () => {
  const playButton = document.querySelector(".play-button");
  const gameInput = document.querySelector(".game-input");


  const startGame = () => {
    playButton.classList.add("hidden");
    gameInput.classList.remove("hidden");

    const answers = document.querySelectorAll(".answer")
    console.log(answers)
  }

  playButton.addEventListener('click', startGame);
}

export { initGame }

// making an array with all the all the question answers
// set the current answer as the first answer
// set the current index as 0
// add an event listener to the game input that listens to a change in the value
// check if the value is the as the current answer, if it is we empty the input and put answer in cell
// update our current index and current answer
// add active row to next cell
// post results to db


// timer
// score
// kana count
