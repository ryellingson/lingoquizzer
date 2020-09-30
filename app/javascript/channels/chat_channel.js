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
    // Called when there's incoming data on the websocket for this channel
    if (data.type === 'badge') {
      console.log(data);

      Swal.fire({
        title: 'Sweet!',
        text: `You got the ${data.badge.description} badge!`,
        imageUrl: data.badge_image_url,
        imageWidth: 200,
        imageHeight: 200,
        imageAlt: 'Custom image',
      })
    } else {

      const chatBox = document.getElementById("chatbox");

      chatBox.insertAdjacentHTML('beforeend', data.content);

      this.alignMessages();

      chatBox.scrollTop = chatBox.scrollHeight;

    // badge handling, may refactor to another connection in future
  }
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
