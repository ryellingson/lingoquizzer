const initMessageScroll = () => {
  $(document).ready(function() {
    var messages = $('#chatbox');

    function messageScroll() {
      messages.scrollTop(messages[0].scrollHeight);
    }

    window.setTimeout(messageScroll, 10);
    console.log("scrolled")
  });
}

export { initMessageScroll }
