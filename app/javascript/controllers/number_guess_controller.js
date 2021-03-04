import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["guessSubmit", "guessField", "guesses", "lastResult", "lowOrHi", "numbers"]

  connect() {
    console.log("Welcome to number guess!");
    this.numbers = JSON.parse(this.numbersTarget.dataset.numbers);
    console.log(this.numbers);
    this.randomNumber = Math.floor(Math.random() * 100) + 1;
    // parse to int

    this.guessCount = 1;
    this.guessFieldTarget.focus();
  }

  checkGuess() {
    console.log('checking guess')
    let userGuess = Number(this.guessFieldTarget.value);
    if (this.guessCount === 1) {
      this.guessesTarget.textContent = 'Previous guesses: ';
    }
    this.guessesTarget.textContent += userGuess + ' ';

    if (userGuess === this.randomNumber) {
      this.lastResultTarget.textContent = 'Congratulations! You got it right!';
      this.lastResultTarget.style.backgroundColor = 'green';
      this.lowOrHiTarget.textContent = '';
      setGameOver();
    } else if (this.guessCount === 10) {
      this.lastResultTarget.textContent = '!!!GAME OVER!!!';
      setGameOver();
    } else {
      this.lastResultTarget.textContent = 'Wrong!';
      this.lastResultTarget.style.backgroundColor = 'red';
      if(userGuess < this.randomNumber) {
        this.lowOrHiTarget.textContent = 'Last guess was too low!';
      } else if(userGuess > this.randomNumber) {
        this.lowOrHiTarget.textContent = 'Last guess was too high!';
      }
    }

    this.guessCount++;
    this.guessFieldTarget.value = '';
    this.guessFieldTarget.focus();
  }

  setGameOver() {
    this.guessFieldTarget.disabled = true;
    this.guessSubmitTarget.disabled = true;
    this.resetButton = document.createElement('button');
    this.resetButton.textContent = 'Start new game';
    document.body.appendChild(this.resetButton);
    this.resetButton.addEventListener('click', resetGame);
  }

  resetGame() {
    this.guessCount = 1;

    const resetParas = document.querySelectorAll('.resultParas p');
    for (let i = 0 ; i < resetParas.length ; i++) {
      resetParas[i].textContent = '';
    }

    this.resetButton.parentNode.removeChild(this.resetButton);

    this.guessFieldTarget.disabled = false;
    this.guessSubmitTarget.disabled = false;
    this.guessFieldTarget.value = '';
    this.guessFieldTarget.focus();

    this.lastResultTarget.style.backgroundColor = 'white';

    this.randomNumber = Math.floor(Math.random() * 100) + 1;
  }
}
