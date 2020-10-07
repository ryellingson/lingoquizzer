import consumer from "./consumer"

const initPostCable = () => {
  const postContainer = document.querySelector('.post-main-container');
  const postsIndex = document.querySelector('#posts');

  if (postContainer || postsIndex) {
    const id = postsIndex ? "index" : postContainer.dataset.postId;
    consumer.subscriptions.create({channel: "PostChannel", id: id}, {
      connected() {
        // Called when the subscription is ready for use on the server
        console.log('connected to posts', 'id:' + id);
        fetch('/notify_badges');
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        // Called when there's incoming data on the websocket for this channel
        console.log(data)
        if (data.comments && postContainer) {
          const commentsDisplay = document.querySelector(".comments-display");
          commentsDisplay.innerHTML = data.comments;
          const commentForm = document.querySelector(".comment-form");
          commentForm.value = "";
        } else if (postsIndex && data.post) {
          postsIndex.insertAdjacentHTML('afterbegin', data.post);
        }

      }
    });
  }
}

export { initPostCable }
