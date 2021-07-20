import { Controller } from "stimulus"
import { ClassicQuiz } from "../components/games/classic_quiz.js"

export default class extends Controller {
  static targets = [ "questionField", "correctCount", "score", "timer" ]

  connect() {
    console.log('Hello, from place holder!');
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

    this.classicQuiz = new ClassicQuiz(this.questionData);
    this.points = 5;
  }

  startGame() {
    // reset parameters
    this.classicQuiz.resetGame(problems)
    // populate the question area
    this.questionFieldTarget.innerHTML = this.classicQuiz.currentQuestion();
    // play button disappears
    // timer starts
    // cursor focused to form
    console.log("starting game");
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
      this.classicQuiz.incrementScore(this.points);
      // add visual confirmation (green outline)
      this.questionFieldTarget.style.border = "solid 3px green"
    } else {
      // present error colors (red outline) and message
      this.questionFieldTarget.style.border = "solid 3px red"
    }
  }
}
