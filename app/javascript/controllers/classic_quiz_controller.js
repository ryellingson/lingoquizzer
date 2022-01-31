import { bind } from 'wanakana';
import { Controller } from "stimulus"
import { ClassicQuiz } from "../components/games/classic_quiz.js"

import Kuroshiro from "kuroshiro";
// Initialize kuroshiro with an instance of analyzer (You could check the [apidoc](#initanalyzer) for more information):
// For this example, you should npm install and import the kuromoji analyzer first
import KuromojiAnalyzer from "kuroshiro-analyzer-kuromoji";

export default class extends Controller {
  static targets = [ "questionField", "correctCount", "score", "timer", "input", "nextArrow", "playButton" ]

  async connect() {
    console.log('Hello, from classic quiz!');
    this.gameRunning = false;
    this.fullTime = 30;

    // Instantiate
    this.kuroshiro = new Kuroshiro();

    // Initialize
    // Here uses async/await, you could also use Promise
    await this.kuroshiro.init(new KuromojiAnalyzer());
    this.questionData = this.buildQuestions();
    
    
    this.pointsPerQuestion = 5;
    this.classicQuiz = new ClassicQuiz(this.questionData, this.fullTime, this.pointsPerQuestion);
    this._resetUI();
    bind(this.inputTarget);
  }

  fetchQuestions() {

  }
  
  buildQuestions() {
    // returns an array with this structure
    // this.questionData = [
    //   {
    //     question: "食べる(past tense polite)",
    //     answer: "たべました"
    //   },
    //   {
    //     question: "読む(present tense polite)",
    //     answer: "よみます"
    //   },
    //   {
    //     question: "走る(past tense plain)",
    //     answer: "はした"
    //   }
    // ]

    // call API
    const response = this.fetchQuestions();
    // API sends questions in this format 

    // {
    //   "data": {
    //     "randomList": [
    //       {
    //         "dictionary_form": "残す",
    //         "short_present_form": "残す",
    //         "short_present_negative_form": "残さない",
    //         "polite_present_form": "残します",
    //         "polite_present_negative_form": "残しません"
    //       },
    //       {
    //         "dictionary_form": "寄る",
    //         "short_present_form": "寄る",
    //         "short_present_negative_form": "寄らない",
    //         "polite_present_form": "寄ります",
    //         "polite_present_negative_form": "寄りません"
    //       }
    //     ]
    //   }
    // }

    // convert randomList array into format of questionData array
    response.data.randomList.map(element => {
      // access dictionary form
      const dictionaryForm = element.dictionary_form;
      // put the keys from the obj into an array, so we can select one at random and exclude dictionary form
      const possibleForms = Object.keys(element).filter(form => (form !== "dictionary_form"));
      // randomly pick target form
      const targetForm = possibleForms[Math.floor(Math.random() * possibleForms.length)];
      // take value of target form as answer
      // convert answer into hiragana
      const answer = this.convertToHiragana(element[targetForm]);
      console.log("answer", answer);
      // return the obj below
      {
        question: `${dictionaryForm} (${targetForm})`,
        answer
      }
    });
    

  }

  async convertToHiragana(string) {
    // Convert what you want
    // using kuroshiro (a package) to convert kanji to hiragana
    return await this.kuroshiro.convert(string, { to: "hiragana" });
  }

  startGame(event) {
    // gameRunning attribute changes from false to true
    this.gameRunning = true;
    // reset parameters
    this.classicQuiz.resetGame(this.questionData);
    // populate the question area
    this.questionFieldTarget.innerHTML = this.classicQuiz.currentQuestion();
    // play button disappears
    this.playButtonTarget.style.display = "none";
    // timer starts
    this.classicQuiz.start();
    // starts the UI
    this._startUI();

    console.log("starting game");
  }

  endGame() {
    console.log("endgame");
    // gameRunning attribute changes from true to false
    this.gameRunning = false;
    this.classicQuiz.stopGame();
    this._displayEndGameModal();
    this._updateUI();
    this._resetUI();
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
    console.log("next ui")
    if (!this.classicQuiz.nextQuestion()) {
      this.endGame();
    }
    this._updateUI();
  }

  _startUI() {
    this.inputTarget.disabled = false;
    this.nextArrowTarget.style.display = "unset";
    // cursor focused to form
    this.inputTarget.focus();
    const uiInterval = setInterval(() => {
      this._displayTime();
      if (this.classicQuiz.timeLeft <= 0) {
        this.endGame();
        clearInterval(uiInterval);
      }
    }, 1000);
    this._displayCorrectCount();
    this._displayScore();
  }

  _updateUI() {
    this.questionFieldTarget.innerText = this.classicQuiz.currentQuestion() || "End of game";
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

  _resetUI() {
    this._displayTime();
    this.inputTarget.disabled = true;
    this.nextArrowTarget.style.display = "none";
    this.questionFieldTarget.innerHTML = "";
    // play button appears
    this.playButtonTarget.style.display = "unset";
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
