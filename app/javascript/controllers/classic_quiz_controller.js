import { bind } from 'wanakana';
import { Controller } from "stimulus"
import { ClassicQuiz } from "../components/games/classic_quiz.js"

import Kuroshiro from "kuroshiro";
// Initialize kuroshiro with an instance of analyzer (You could check the [apidoc](#initanalyzer) for more information):
// For this example, you should npm install and import the kuromoji analyzer first
import KuromojiAnalyzer from "kuroshiro-analyzer-kuromoji";

export default class extends Controller {
  static targets = [ "questionField", "questionBanner", "correctCount", "score", "timer", "input", "nextArrow", "playButton" ]

  async connect() {
    console.log('Hello, from classic quiz!');
    this.gameRunning = false;
    this.fullTime = 300;
    this.pointsPerQuestion = 5;

    this._resetUI();

    // Instantiate kuroshiro
    this.kuroshiro = new Kuroshiro();

    // Initialize KuromojiAnalyzer
    // Here uses async/await, you could also use Promise
    const analyzer = new KuromojiAnalyzer(
      { dictPath: "/kuromoji/dict" } // this points to the public/kuromoji/dict folder which was created as a workaround to bypass an error with kuromoji looking in the wrong place possibly because of webpacker
    );
    await this.kuroshiro.init(analyzer);
    // bind(this.inputTarget);
  }

  async fetchQuestions() {
    // query requests the randomList query as defined in the Graphql resolvers
    // we have explicitly written out the verb forms we want
    const query = `query {
      randomList {
        dictionary_form
        short_present_form
        short_present_negative_form
    		polite_present_form
        polite_present_negative_form
      }
    }`;

    // Here we make an API call to the Graphql endpoint 
    // example https://www.netlify.com/blog/2020/12/21/send-graphql-queries-with-the-fetch-api-without-using-apollo-urql-or-other-graphql-clients/
    let response = await fetch("http://localhost:4000", { 
      method: "POST", 
      body: JSON.stringify({ query }),
      headers: {'Content-Type': 'application/json'}
    });
    // extract the body from the response
    const data = await response.json();
    return data;
    // console.log('data: ', data);

  }
  
  async buildQuestions() {
    // call API and store in response
    const response = await this.fetchQuestions();
    // convert randomList array into format of questionData array
    // we need to wait for each promise in the map array to resolve
    return await Promise.all(response.data.randomList.map(async element => {
      // access dictionary form
      const dictionaryForm = element.dictionary_form;
      // put the keys from the obj into an array, so we can select one at random and exclude dictionary form
      const possibleForms = Object.keys(element).filter(form => (form !== "dictionary_form"));
      // randomly pick target form
      const targetForm = possibleForms[Math.floor(Math.random() * possibleForms.length)];
      // take value of target form as answer
      // convert answer into hiragana
      const answer = await this.convertToHiragana(element[targetForm]);
      // console.log("answer", answer);
      // return the obj below
      return {
        question: `${dictionaryForm} (${targetForm})`,
        answer
      }
    }));
    

  }

  async convertToHiragana(string) {
    // Convert what you want
    // using kuroshiro (a package) to convert kanji to hiragana
    return await this.kuroshiro.convert(string, { to: "hiragana" });
  }

  async startGame(event) {
    this.questionData = await this.buildQuestions();
    // create an instance of our ClassicQuiz class, passing it questionData taken from the API
    this.classicQuiz = new ClassicQuiz(this.questionData, this.fullTime, this.pointsPerQuestion);
    // gameRunning attribute changes from false to true
    this.gameRunning = true;
    // reset parameters
    this.classicQuiz.resetGame(this.questionData);
    console.log('this.questionData: ', this.questionData);
    // populate the question area
    this.questionFieldTarget.innerHTML = this.classicQuiz.currentQuestion();
    console.log('this.classicQuiz: ', this.classicQuiz);
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

  _displayTime(time = null) {
    // we can pass a time directly, useful when ClassicQuiz is not instantiated
    const timeLeft = time ? time : this.classicQuiz.timeLeft;
    const sec = timeLeft % 60;
    this.timerTarget.innerText = `${Math.floor(timeLeft / 60)}:${sec < 10 ? "0" + sec : sec}`;
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
      this.questionBannerTarget.style.transition = "ease 2s";
      this.questionBannerTarget.style.backgroundColor = "green";
      this.inputTarget.value = "";
    } else {
      // present error colors (red outline) and message
      this.questionBannerTarget.style.transition = "ease 2s";
      this.questionBannerTarget.style.backgroundColor = "red";
    }
    this._displayScore();
    this._displayCorrectCount();
  }

  _resetUI() {
    this._displayTime(this.fullTime);
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
