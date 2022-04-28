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
    this.fullTime = this.element.dataset.playTime;
    this.pointsPerQuestion = 5;

    this._resetUI();

    // Instantiate kuroshiro
    this.kuroshiro = new Kuroshiro();

    // Initialize KuromojiAnalyzer
    // Here we use async/await, you could also use Promise
    const analyzer = new KuromojiAnalyzer(
      { dictPath: "/kuromoji/dict" } // this points to the public/kuromoji/dict folder which was created as a workaround to bypass an error with kuromoji looking in the wrong place possibly because of webpacker
    );
    await this.kuroshiro.init(analyzer);
    bind(this.inputTarget);
  }

  async fetchQuestions(problemCount) {
    // query requests the randomList query as defined in the Graphql resolvers
    // we have explicitly written out the verb forms we want
    const query = `query {
      randomList(size: ${problemCount}) {
        dictionary_form
        short_present_form
        short_present_negative_form
    		polite_present_form
        polite_present_negative_form
      }
    }`;

    // here we make an API call to the Graphql endpoint 
    // example: https://www.netlify.com/blog/2020/12/21/send-graphql-queries-with-the-fetch-api-without-using-apollo-urql-or-other-graphql-clients/
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
    const response = await this.fetchQuestions(this.element.dataset.problemCount);
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
      // return the obj below
      return {
        question: `${dictionaryForm} (${targetForm.replaceAll("_", " ")})`,
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

  _postResults() {
    console.log("posting");
    // we grab data from the html data atrributes to use in our JS
    const postURL = this.element.dataset.url;
    return fetch(postURL, {
      method: "POST",
      body: JSON.stringify({
        play: {
          score: this.classicQuiz.score,
          time: (this.fullTime - this.classicQuiz.timeLeft),
          count: this.classicQuiz.correctCountValue
        }
      }),
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": Rails.csrfToken(),
      }
    })
  }

  async endGame() {
    console.log("endgame");
    // gameRunning attribute changes from true to false
    this.gameRunning = false;
    this.classicQuiz.stopGame();
    await this._postResults();
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
    this.correctCountTarget.innerText = `${this.classicQuiz.correctCountValue}/${this.classicQuiz.problemCount}`
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
    if (this.classicQuiz.gameWon()) {
      this.endGame();
    } else {
      this._updateUI();
    }
  }

  next() {
    console.log("next ui")
    this.inputTarget.value = "";
    // if (!this.classicQuiz.nextQuestion()) {
    //   this.endGame();
    // }
    this._updateUI();
  }

  _startUI() {
    // enables the answer form
    this.inputTarget.disabled = false;
    // resets the next arrow to its inherited style value, making it visible again
    this.nextArrowTarget.style.display = "unset";
    // cursor focused to form
    this.inputTarget.focus();
    // begins displaying time, ends the game when the timer reaches 0, and stops the timer
    const uiInterval = setInterval(() => {
      this._displayTime();
      if (this.classicQuiz.timeLeft <= 0) {
        this.endGame();
        clearInterval(uiInterval);
      }
    }, 1000);
    // displays relevant data to users
    this._displayCorrectCount();
    this._displayScore();
  }

  _updateUI() {
    // either displays the current question or prompts the user that the game is over
    this.questionFieldTarget.innerText = this.classicQuiz.currentQuestion() || "Great Play!";
    // displays the neutral color
    if (this.classicQuiz.greenLight === null) {
      this.questionBannerTarget.style.transition = "ease 0.3s";
      this.questionBannerTarget.style.backgroundColor = null;
    } else if (this.classicQuiz.greenLight) {
      // displays the correct answer color and clears the form
      this.questionBannerTarget.style.transition = "ease 1s";
      this.questionBannerTarget.style.backgroundColor = "green";
      this.inputTarget.value = "";
    } else {
      // displays the wrong answer color
      this.questionBannerTarget.style.transition = "ease 1s";
      this.questionBannerTarget.style.backgroundColor = "firebrick";
    }
    // displays relevant data to users
    this._displayScore();
    this._displayCorrectCount();
  }

  _resetUI() {
    // puts banner display to neutral color
    this.questionBannerTarget.style.backgroundColor = null;
    // resets the timer
    this._displayTime(this.fullTime);
    // disables the form
    this.inputTarget.disabled = true;
    // hides the next arrow
    this.nextArrowTarget.style.display = "none";
    // clears the form
    this.questionFieldTarget.innerHTML = "";
    // play button reappears
    this.playButtonTarget.style.display = "unset";
  }

  _displayEndGameModal() {
    // checks for a perfect play, and fires the relevant endgame modal
    if (this.classicQuiz.correctCountValue === this.classicQuiz.problemCount) {
      Swal.fire({
        imageUrl: this.element.dataset.perfectPlayUrl,
        imageWidth: 200,
        imageHeight: 200,
        imageAlt: 'Perfect Play',
        title: '<u>Perfect Play!</u>',
        html:
          `<div>Time Bonus: ${this.classicQuiz.timeLeft}pts</div><br>` +
          `<div>Correct Answers: ${this.classicQuiz.correctCountValue}/${this.classicQuiz.problemCount}</div><br>` +
          `<div>Score: ${this.classicQuiz.score}pts</div>`
      });
    } else {
      Swal.fire({
        icon: 'success',
        title: '<u>Nice Play!</u>',
        html:
          `<div>Time Bonus: ${this.classicQuiz.timeLeft}pts</div><br>` +
          `<div>Correct Answers: ${this.classicQuiz.correctCountValue}/${this.classicQuiz.problemCount}</div><br>` +
          `<div>Score: ${this.classicQuiz.score}pts</div>`
      });
    }
  }
}
