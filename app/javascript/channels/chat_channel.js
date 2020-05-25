import consumer from "./consumer"

consumer.subscriptions.create("ChatChannel", {
  connected() {
    console.log("yeehaw we are live!")
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // $(".message-text").append('<div class="message-broadcast">' + data.content + '</div>')

    // const chatMessages document.querySelector(".chat-messages");
    // const message document.querySelector(".message");



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
