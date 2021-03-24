import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [
    "guessSubmit",
    "guessField",
    "guesses",
    "lastResult",
    "lowOrHi",
    "numbers",
    "startButton",
    "quitButton",
    "timeShow"
  ]

  connect() {
    console.log("Welcome to number guess!");
    this.numbers = JSON.parse(this.numbersTarget.dataset.numbers);
    console.log("data", this.numbers)

    this.reverseNumbers = this.reverseNumbersDict(this.numbers);
    console.log("reverse", this.reverseNumbers);

    this.max = Math.max(...Object.keys(this.numbers).map((e) => parseInt(e)));

    this.guessFieldTarget.focus();

    this.startButtonTarget.classList.remove('hidden');
    this.guessFieldTarget.disabled = true;
    this.guessSubmitTarget.disabled = true;
    this.guessSubmitTarget.classList.add("btn-disabled");
  }

  reverseNumbersDict(dict) {
    let revdict = {};
    Object.keys(dict).forEach((numkey) => {
      // ["1", "2", "3", ...]
      Object.values(dict[numkey]).forEach((answer) => {
        // ["ichi", "いち", "一"], ...
        // if (answer == array) then iterate over array to assign the keys
        // else line 42
        revdict[answer] = parseInt(numkey);
      });
    });
    return revdict;
    // {"ichi": 1, "いち": 1, "一": 1, "ni": 2, "san": 3, ...}
    // dict[key] = value
  }

  startGame() {
    this.startButtonTarget.classList.add('hidden');
    this.quitButtonTarget.classList.remove('hidden');

    this.guessCount = 0;

    const resetParas = document.querySelectorAll('.resultParas p');
    for (let i = 0 ; i < resetParas.length ; i++) {
      resetParas[i].textContent = '';
    }

    this.timeLeft = this.element.dataset.playTime;
    this.interval = setInterval(this.updateTimer, 1000);

    this.guessSubmitTarget.classList.remove("btn-disabled");
    this.guessFieldTarget.disabled = false;
    this.guessSubmitTarget.disabled = false;
    this.guessFieldTarget.value = '';
    this.guessFieldTarget.focus();

    this.lastResultTarget.style.backgroundColor = 'white';

    this.randomNumber = Math.floor(Math.random() * this.max);
    console.log("rand =" ,this.randomNumber);
  }

  updateTimer = () => {
    this.timeLeft -= 1;
    const sec = this.timeLeft % 60;
    this.timeShowTarget.innerHTML = `${Math.floor(this.timeLeft / 60)}:${sec < 10 ? "0" + sec : sec}`;
    if (this.timeLeft == 0) { this.endGame() };
  }

  convertInputToInteger(input) {

  }

  checkGuess() {
    this.guessCount++;
    let userInput = this.guessFieldTarget.value;
    let userGuess = convertInputToInteger(userInput);

    if (this.guessCount === 1) {
      this.guessesTarget.textContent = 'Previous guesses: ';
    }
    this.guessesTarget.textContent += userGuess + ' ';

    if (userGuess === this.randomNumber) {
      this.lastResultTarget.textContent = 'Congratulations! You got it right!';
      this.lastResultTarget.style.backgroundColor = 'green';
      this.lowOrHiTarget.textContent = '';
      this.endGame();
    } else if (this.guessCount === 10) {
      this.lastResultTarget.textContent = '!!!GAME OVER!!!';
      this.endGame();
    } else {
      this.lastResultTarget.textContent = 'Wrong!';
      this.lastResultTarget.style.backgroundColor = 'red';
      if(userGuess < this.randomNumber) {
        this.lowOrHiTarget.textContent = 'Last guess was too low!';
      } else if(userGuess > this.randomNumber) {
        this.lowOrHiTarget.textContent = 'Last guess was too high!';
      }
    }

    this.guessFieldTarget.value = '';
    this.guessFieldTarget.focus();
  }

  endGame() {
    console.log('guess count', this.guessCount)
    clearInterval(this.interval);

    // this.displayEndGameModal();
    // this.postResults();

    this.guessFieldTarget.disabled = true;
    this.guessSubmitTarget.disabled = true;

    this.startButtonTarget.classList.remove('hidden');
    this.quitButtonTarget.classList.add('hidden');
    this.guessSubmitTarget.classList.add("btn-disabled");
  }


  postResults() {

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
          `<div>Correct Answer: ${this.randomNumber}</div><br>` +
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
}
