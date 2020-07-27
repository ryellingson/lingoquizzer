import { Controller } from "stimulus"
import EmojiButton from '@joeattardi/emoji-button';

export default class extends Controller {
  static targets = [ "messages", "chatInput", "form" ]

  connect() {
    console.log('Hello, from the conversations controller')
    this.scrollToBottom()
    this.alignMessages()
  }

  new() {
    console.log('made it to the create partial')
  }

  scrollToBottom() {
    this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight;
  }

  clearInput() {
    this.chatInputTarget.value = '';
  }

  submit() {
    this.formTarget.submit()
    this.clearInput()
  }

  submitOnKeyDown(event) {
    if (event.key === "Enter") {
      event.preventDefault()
      this.submit()
    }
  }

  toggleEmojis(event) {
    const picker = new EmojiButton({
      emojiSize: "3em"
    });
    picker.on('emoji', emoji => {
      this.chatInputTarget.value += emoji;
    });
    picker.togglePicker(event.currentTarget);
  }

  alignMessages() {
    const messages = document.querySelectorAll('#chatbox .message');
    const currentUserId = document.querySelector('body').dataset.userId;
    messages.forEach(message => {
      if (message.dataset.authorId === currentUserId) {
        message.classList.add('current-user');
      }
    });
  }
}
