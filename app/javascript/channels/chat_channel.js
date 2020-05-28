import consumer from "./consumer"

consumer.subscriptions.create("ChatChannel", {
  connected() {
    console.log("yeehaw we are live!");
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    console.log("signing off");
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const messageAvatar = data.avatar.default ?
    `<div class="default-message-avatar">
      ${data.avatar.content}
    </div>`
     :
    `<img src=${data.avatar.content} class="message-avatar">`

    const message =
    `<div class="message">
      <div class="message-avatar-wrapper">
        ${messageAvatar}
      </div>
      <div class="message-content">
        <div class="message-header">
          <div class="message-user">
            <p>${data.username}</p>
          </div>
          <div class="message-creation-time">
            <p>${data.created_at}</p>
          </div>
        </div>
        <div class="message-text">
          ${data.content}
        </div>
      </div>
    </div>`;

    const chatBox = document.getElementById("chatbox");

    chatBox.insertAdjacentHTML('beforeend', message);

    chatBox.scrollTop = chatBox.scrollHeight;


    console.log(data.content);
    // Called when there's incoming data on the websocket for this channel
  }
});

var submit_messages;

$(document).on('turbolinks:load', function() {
  submit_messages();
})


submit_messages =  function(){
  $('#message_content').on('keydown', function(event) {
    if (event.keyCode === 13) {
      $('input').click()
      event.target.value = '';
      event.preventDefault();
      console.log('you hit enter lets clear input');
    }
  })
}
