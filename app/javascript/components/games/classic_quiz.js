export class ClassicQuiz  {
  constructor(problems, fullTime, points) { // problems is a set of questions and answers
    this.fullTime = fullTime;
    this.resetGame(problems);
    this.pointsPerQuestion = points;
  }

  start() {
    this._startTimer()
  }

  nextQuestion() {
    // check that there is a next question
    this.currentProblemIndex += 1;
    this.answerCount += 1;
  }

  currentQuestion() {
    return this.problems[this.currentProblemIndex].question;
  }

  incrementScore(points = this.pointsPerQuestion) {
    this.score += points;
  }

  checkAnswer(input) {
    console.log("checkAnswer");
    if (input === this.problems[this.currentProblemIndex].answer) {
      this.incrementScore();
      return true;
    }
    return false;
  }

  resetGame(problems, fullTime = this.fullTime) {
    this.score = 0;
    this.currentProblemIndex = 0;
    this.problems = problems;
    this.timeLeft = fullTime;
    this.correctCountValue = 0;
    this.answerCount = 0;
  }

  _startTimer() {
    setInterval(() => {
      this.timeLeft -= 1;
    }, 1000);
  }
}
