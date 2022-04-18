export class ClassicQuiz  {
  constructor(problems, fullTime, points) { // problems is a set of questions and answers
    // declaring what the constructor is looking for
    this.fullTime = fullTime;
    this.resetGame(problems);
    this.pointsPerQuestion = points;
  }

  start() {
    this._startTimer()
  }

  nextQuestion() {
    // moves through the problems array
    console.log("next");
    this.currentProblemIndex += 1;
    this.answerCount += 1;
    // greenlight is null because
    this.greenLight = null;
    // then we return the
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
    // checks if the users input matches the answer found at the current problem 
    if (input === this.problems[this.currentProblemIndex].answer) {
      this.incrementScore();
      this.correctCountValue += 1;
      // greenLight will be used by out _updateUI method to display a CORRECT result to users
      this.greenLight = true;
      return true;
    }
    // greenLight will be used by out _updateUI method to display a INCORRECT result to users
    this.greenLight = false;
    return false;
  }

  gameWon() {
    // used by classic_quiz_controller to check if the user has gotten all the answers right
    return this.correctCountValue === this.problemCount;
  }

  resetGame(problems, fullTime = this.fullTime) {
    // resets all game parameters
    this.score = 0;
    this.currentProblemIndex = 0;
    this.problems = problems;
    this.timeLeft = fullTime;
    this.correctCountValue = 0;
    this.answerCount = 0;
    this.problemCount = problems.length;
    // greenLight is true when the last checked answer returns and is used to change enter to nextQuestion
    this.greenLight = null;
  }

  stopGame() {
    // called in classic_quiz_controller to stop the timer
    clearInterval(this.gameTimer);
  }

  _startTimer() {
    this.gameTimer = setInterval(() => {
      this.timeLeft -= 1;
    }, 1000);
  }
}
