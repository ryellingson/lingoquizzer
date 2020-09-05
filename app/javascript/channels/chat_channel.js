import consumer from "./consumer"

consumer.subscriptions.create("ChatChannel", {
  connected() {
    // console.log("yeehaw we are live!");
    // Called when the subscription is ready for use on the server
    this.alignMessages();
  },

  disconnected() {
    // console.log("signing off");
    // Called when the subscription has been terminated by the server
  },

  received(data) {

    const chatBox = document.getElementById("chatbox");

    chatBox.insertAdjacentHTML('beforeend', data.content);

    this.alignMessages();

    chatBox.scrollTop = chatBox.scrollHeight;

    // Called when there's incoming data on the websocket for this channel
  },

  alignMessages() {
    const messages = document.querySelectorAll('#chatbox .message');
    const currentUserId = document.querySelector('body').dataset.userId;
    messages.forEach(message => {
      if (message.dataset.authorId === currentUserId) {
        message.classList.add('current-user');
      }
    });
  }
});
