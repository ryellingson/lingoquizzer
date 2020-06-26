class PostsController < ApplicationController
  before_action :set_language
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    if params[:lang]
      @posts = @language.posts.with_rich_text_content_and_embeds
      skip_policy_scope # pundit method used inside index
    else
      @posts = policy_scope(Post) # This substitutes Post.all
    end
    render layout: "conversations"
  end

  def show
    @post = Post.with_rich_text_content_and_embeds.find(params[:id])
    authorize @post
    @language = @post.language
    @comments = @post.comments
    render layout: "conversations"
  end

  def new
    @post = Post.new
    authorize @post
    respond_to do |format|
      format.js
      format.html { render layout: "conversations" }
    end
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post
  end

  def create
    @language = Language.find(params[:post][:language_id])
    @post = Post.new(post_params)
    @post.user = current_user
    authorize @post
    if @post.save
      redirect_to post_path(@post)
    else
      render :new, layout: "conversations"
    end
  end

  private

  def set_language
    @language = Language.find_by(language_code: params[:lang])
  end

  def post_params
    params.require(:post).permit(:language_id, :title, :content)
  end
end
