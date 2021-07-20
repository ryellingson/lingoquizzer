export class ClassicQuiz = {
  constructor(problems) { // problems is a set of questions and answers
    this.resetGame(problems);
  }

  nextQuestion() {
    // check that there is a next question
    this.currentProblemIndex += 1;
  }

  currentQuestion() {
    return this.problems[this.currentProblemIndex].question;
  }

  incrementScore(points) {
    this.score += points;
  }

  checkAnswer(input) {
    console.log("checkAnswer");
    return input === this.problems[this.currentProblemIndex].answer;
  }

  resetGame(problems) {
    this.score = 0;
    this.currentProblemIndex = 0;
    this.problems = problems;
    // this.time = fullTime;
    // this.correctCount = 0;
  }
}
