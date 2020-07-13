import consumer from "./consumer"
console.log("Loading chat_channel.js");

consumer.subscriptions.create("ChatChannel", {
  connected() {
    console.log("yeehaw we are live!");
    // Called when the subscription is ready for use on the server
    this.alignMessages();
  },

  disconnected() {
    console.log("signing off");
    // Called when the subscription has been terminated by the server
  },

  received(data) {

    const chatBox = document.getElementById("chatbox");

    chatBox.insertAdjacentHTML('beforeend', data.content);

    this.alignMessages();

    chatBox.scrollTop = chatBox.scrollHeight;

    // console.log(data.content);
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

// var submit_messages;

// $(document).on('turbolinks:load', function() {
//   submit_messages();
// })


// submit_messages =  function(){
//   $('#message_content').on('keydown', function(event) {
//     if (event.keyCode === 13) {
//       $('input').click()
//       event.target.value = '';
//       event.preventDefault();
//       console.log('you hit enter lets clear input');
//     }
//   })
// }
