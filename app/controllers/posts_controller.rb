class PostsController < ApplicationController
  before_action :set_language

  def index
    if params[:lang]
      @posts = Language.find_by(language_code: params[:lang]).posts
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
    if @post.save
      respond_to do |format|
        format.js
        format.html { redirect_to post_path(@post) }
      end
    end
  end

  private

  def set_language
    @language = Language.find_by(language_code: params[:lang])
    # binding.pry
  end

  def post_params
    params.require(:post).permit(:language_id, :title, :content)
  end
end
