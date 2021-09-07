import { Controller } from "stimulus"
import { ClassicQuiz } from "../components/games/classic_quiz.js"

export default class extends Controller {
  static targets = [ "questionField", "correctCount", "score", "timer", "input" ]

  connect() {
    console.log('Hello, from place holder!');
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
    this._startUI()

    console.log("starting game");
  }

  _displayTime() {
    const sec = this.classicQuiz.timeLeft % 60;
    this.timerTarget.innerText = `${Math.floor(this.classicQuiz.timeLeft / 60)}:${sec < 10 ? "0" + sec : sec}`;
  }

  _displayScore() {
    this.scoreTarget.innerText = `${this.classicQuiz.score}pts`;
  }

  _displayCorrectCount() {
    this.correctCountTarget.innerText = `${this.classicQuiz.correctCountValue}/${this.classicQuiz.answerCount}`
  }

  keyUp(e) {
    // if the key is enter, then run checkAnswer
    console.log(e.key);
    if (e.key === 'Enter') {
      console.log("keyup - enter");
    }
  }

  submit(input) {
    if (this.classicQuiz.checkAnswer(input)) {
      // add visual confirmation (green outline)
      this.questionFieldTarget.style.border = "solid 3px green"
    } else {
      // present error colors (red outline) and message
      this.questionFieldTarget.style.border = "solid 3px red"
    }
  }

  _startUI() {
    // cursor focused to form
    this.inputTarget.focus();
    setInterval(() => {
      this._displayTime();
    }, 1000);
    this._displayCorrectCount();
    this._displayScore();
  }
}
