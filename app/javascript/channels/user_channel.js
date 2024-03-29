import consumer from "./consumer"

consumer.subscriptions.create("UserChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    // fetch('/notify_badges');
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    if (data.type === 'badge') {
      Swal.fire({
        title: 'Sweet!',
        text: `You got the ${data.badge.name.toUpperCase().replace(/_/g, " ")} badge for ${data.badge.description}!`,
        imageUrl: data.badge_image_url,
        imageWidth: 200,
        imageHeight: 200,
        imageAlt: 'Custom image'
      });
    }
  }
});
