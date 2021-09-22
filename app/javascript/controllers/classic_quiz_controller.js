import { Controller } from "stimulus"
import { ClassicQuiz } from "../components/games/classic_quiz.js"

export default class extends Controller {
  static targets = [ "questionField", "correctCount", "score", "timer", "input" ]

  connect() {
    console.log('Hello, from classic quiz!');
    this.fullTime = 60;
    this.questionData = [
      {
        question: "食べる(past tense polite)",
        answer: "たべました"
      },
      {
        question: "読む(present tense polite)",
        answer: "よみます"
      },
      {
        question: "走る(past tense plain)",
        answer: "はした"
      }
    ]

    this.pointsPerQuestion = 5;
    this.classicQuiz = new ClassicQuiz(this.questionData, this.fullTime, this.pointsPerQuestion);
  }

  startGame(event) {
    // reset parameters
    this.classicQuiz.resetGame(this.questionData)
    // populate the question area
    this.questionFieldTarget.innerHTML = this.classicQuiz.currentQuestion();
    // play button disappears
    event.currentTarget.style.display = "none";
    // timer starts
    this.classicQuiz.start();
    // starts the UI
    this._startUI();

    console.log("starting game");
  }

  endGame() {
    console.log("endgame");
    this.classicQuiz.stopGame();
    this._updateUI();
    this._displayEndGameModal();
  }

  _displayTime() {
    const sec = this.classicQuiz.timeLeft % 60;
    this.timerTarget.innerText = `${Math.floor(this.classicQuiz.timeLeft / 60)}:${sec < 10 ? "0" + sec : sec}`;
  }

  _displayScore() {
    this.scoreTarget.innerText = `${this.classicQuiz.score}pts`;
  }

  _displayCorrectCount() {
    this.correctCountTarget.innerText = `${this.classicQuiz.correctCountValue}/${this.classicQuiz.totalQuestions}`
  }

  keyUp(e) {
    // if the key is enter, then run checkAnswer
    console.log(e.key);
    if (e.key === 'Enter') {
      if (this.classicQuiz.greenLight) {
        // change enter to call nextQuestion
        this.classicQuiz.nextQuestion();
        this._updateUI();
      } else {
        this.submit(e.currentTarget.value);
      }
    }
  }

  submit(input) {
    this.classicQuiz.checkAnswer(input);
    this._updateUI();
  }

  next() {
    console.log("next ui", this.classicQuiz.currentQuestion())
    if (!this.classicQuiz.nextQuestion()) {
      this.endGame();
    }
    this._updateUI();
  }

  _startUI() {
    // cursor focused to form
    this.inputTarget.focus();
    setInterval(() => {
      this._displayTime();
      if (this.classicQuiz.timeLeft <= 0) {
        this.endGame();
      }
    }, 1000);
    this._displayCorrectCount();
    this._displayScore();
  }

  _updateUI() {
    this.questionFieldTarget.innerText = this.classicQuiz.currentQuestion();
    if (this.classicQuiz.greenLight === null) {
      this.questionFieldTarget.style.border = "none"
    } else if (this.classicQuiz.greenLight) {
      // add visual confirmation (green outline)
      this.questionFieldTarget.style.border = "solid 3px green"
    } else {
      // present error colors (red outline) and message
      this.questionFieldTarget.style.border = "solid 3px red"
    }
    this._displayScore();
    this._displayCorrectCount();
  }

  _displayEndGameModal() {
    if (this.classicQuiz.correctCountValue === this.classicQuiz.totalQuestions) {
      Swal.fire({
        // imageUrl: `${this.classicQuiz.gameDataObject.perfectPlayUrl}`,
        imageWidth: 200,
        imageHeight: 200,
        imageAlt: 'Perfect Play',
        title: '<u>Perfect Play!</u>',
        html:
          `<div>Time Bonus: ${this.classicQuiz.timeLeft}pts</div><br>` +
          `<div>Correct Answers: ${this.classicQuiz.correctCountValue}/${this.classicQuiz.answerCount}</div><br>` +
          `<div>Score: ${this.classicQuiz.score}pts</div>`
      });
    } else {
      Swal.fire({
        icon: 'success',
        title: '<u>Nice Play!</u>',
        html:
          `<div>Time Bonus: ${this.classicQuiz.timeLeft}pts</div><br>` +
          `<div>Correct Answers: ${this.classicQuiz.correctCountValue}/${this.classicQuiz.answerCount}</div><br>` +
          `<div>Score: ${this.classicQuiz.score}pts</div>`
      });
    }
  }
}
