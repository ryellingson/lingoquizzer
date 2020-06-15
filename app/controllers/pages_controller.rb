class PagesController < ApplicationController
  def home
  end

  def conversations
    @messages = Message.all
    @message = Message.new
    @posts = Post.all
    @post = Post.new
    @comments = Comment.all
    @comment = Comment.new
    render(layout: "conversations") do
      # render "posts/forum_container", posts: @posts
      "<h1>TEST</h1>"
    end
  end

  def user_profile
  end

  def leaderboards
    @games = Game.all
  end
end
