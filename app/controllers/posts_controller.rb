class PostsController < ApplicationController

  def index
    if params[:lang] == "ja"
      @posts = Language.first.posts
    else
      @posts = Post.all
    end
    render layout: "conversations"
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    render layout: "conversations"
  end

  def new
    @post = Post.new
    respond_to do |format|
      format.js
      format.html { render layout: "conversations" }
    end
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.save
    respond_to do |format|
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
