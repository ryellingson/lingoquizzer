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
    console.log("next");
    this.currentProblemIndex += 1;
    this.answerCount += 1;
    this.greenLight = null;
    return this.problems[this.currentProblemIndex];
  }

  currentQuestion() {
    return this.problems[this.currentProblemIndex]?.question;
  }

  incrementScore(points = this.pointsPerQuestion) {
    this.score += points;
  }

  checkAnswer(input) {
    console.log("checkAnswer");
    if (input === this.problems[this.currentProblemIndex].answer) {
      this.incrementScore();
      this.correctCountValue += 1;
      this.greenLight = true;
      return true;
    }
    this.greenLight = false;
    return false;
  }

  resetGame(problems, fullTime = this.fullTime) {
    this.score = 0;
    this.currentProblemIndex = 0;
    this.problems = problems;
    this.timeLeft = fullTime;
    this.correctCountValue = 0;
    this.answerCount = 0;
    this.totalQuestions = problems.length;
    // greenLight is true when the last checked answer returns and is used to change enter to nextQuestion
    this.greenLight = null;
  }

  stopGame() {
    clearInterval(this.gameTimer);
  }

  _startTimer() {
    this.gameTimer = setInterval(() => {
      this.timeLeft -= 1;
    }, 1000);
  }
}
