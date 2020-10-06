class PostChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    if params[:id] == "index"
      stream_from "posts"
    else
      post = Post.find(params[:id])
      stream_for post
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
