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
  end

  def user_profile
  end

  def leaderboards
    @games = Game.all
  end
end
