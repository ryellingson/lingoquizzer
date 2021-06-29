import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "questionField" ]

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
    this.currentQuestionIndex = 0;
  }

  startGame() {
    // reset parameters
    // populate the question area
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

  nextQuestion() {
    this.currentQuestionIndex += 1;
  }

  checkAnswer() {
    console.log("checkAnswer");
    // check input against question

    // to check answer
    this.questionData[this.currentQuestionIndex];
    // to track what is the current question: instance variable
    // select answer key and compare against submitted input
  }
}
