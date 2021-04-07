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

    this.winningScore = this.element.dataset.score;
    this.postURL = this.element.dataset.url;
    this.numbers = JSON.parse(this.numbersTarget.dataset.numbers);
    console.log("data", this.numbers)

    this.reverseNumbers = this.reverseNumbersDict(this.numbers);
    console.log("reverse", this.reverseNumbers);

    this.max = Math.max(...Object.keys(this.numbers).map((e) => parseInt(e)));

    let userInput = this.guessFieldTarget.value;
    let userGuess = this.reverseNumbers[userInput];
    console.log("userGuess", userGuess);

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
        if (Array.isArray(answer)) {
          answer.forEach((element) => {
            revdict[element] = parseInt(numkey);
          });
        } else {
            revdict[answer] = parseInt(numkey);
        }
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
    this.score = 0;

    const resetParas = document.querySelectorAll('.resultParas p');
    for (let i = 0 ; i < resetParas.length ; i++) {
      resetParas[i].textContent = '';
    }

    this.initialTime = this.element.dataset.playTime;
    this.timeLeft = this.initialTime;
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

  checkOnEnter(event) {
    if (event.keyCode== 13) this.checkGuess();
  }

  checkGuess() {
    console.log("event", event);
    this.lastResultTarget.textContent = "";

    this.guessFieldTarget.value = '';
    this.guessFieldTarget.focus();

    if (!userGuess) {
      this.lastResultTarget.textContent = "Not a valid input!";
      return;
    }

    this.guessCount++;

    if (this.guessCount === 1) {
      this.guessesTarget.textContent = 'Previous guesses: ';
    }
    this.guessesTarget.textContent += `${userGuess} `;

    if (userGuess === this.randomNumber) {
      // this.lastResultTarget.textContent = 'Congratulations! You got it right!';
      // this.lastResultTarget.style.backgroundColor = 'green';
      this.lowOrHiTarget.textContent = '';
      this.score = this.winningScore;
      this.endGame();
    } else if (this.guessCount === 10) {
      this.lastResultTarget.textContent = '!!!GAME OVER!!!';
      this.score = 0;
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
  }

  endGame() {
    console.log('guess count', this.guessCount)
    clearInterval(this.interval);

    this.displayEndGameModal();
    this.postResults();

    this.guessFieldTarget.disabled = true;
    this.guessSubmitTarget.disabled = true;

    this.startButtonTarget.classList.remove('hidden');
    this.quitButtonTarget.classList.add('hidden');
    this.guessSubmitTarget.classList.add("btn-disabled");
  }


  postResults() {
    console.log("posting");
    fetch(this.postURL, {
      method: "POST",
      body: JSON.stringify({
        play: {
          score: this.score,
          time: (this.initialTime - this.timeLeft),
          count: this.guessCount
        }
      }),
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": Rails.csrfToken(),
      }
    })
    console.log("posted");
  }

  displayEndGameModal() {
    if (userGuess === this.randomNumber) {
      Swal.fire({
        imageUrl: `${this.gameDataObject.perfectPlayUrl}`,
        imageWidth: 200,
        imageHeight: 200,
        imageAlt: 'Perfect Play',
        title: '<u>Perfect Play!</u>',
        // icon: 'success',
        html:
          `<div>You got it right!<div>` +
          `<div>Correct Answer: ${this.randomNumber}</div><br>` +
          `<div>Score: ${this.score}pts</div>`
      });
    } else {
      Swal.fire({
        icon: 'error',
        title: '<u>Game Over!!!</u>',
        html:
          `<div>Try again, you're so close!</div>`
      });
    }
    this.playButtons.forEach((button) => button.classList.remove("hidden"));
    this.quitButtons.forEach((button) => button.classList.add("hidden"));
  }
}
