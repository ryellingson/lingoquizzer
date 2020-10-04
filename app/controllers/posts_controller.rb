class PostsController < ConversationsController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  skip_before_action :set_slideshow_keywords, only: [ :update, :create, :show, :edit ]

  def index
    if params[:lang]
      @posts = @language.posts.order(created_at: :desc).paginate(page: params[:page], per_page: 20)
      skip_policy_scope # pundit method used inside index
    else
      @posts = policy_scope(Post).paginate(page: params[:page], per_page: 20) # This substitutes Post.all
    end
    respond_to do |format|
      format.html { render layout: "conversations" }
      format.json  do
        render json: {content: render_to_string(partial: 'posts/page_content', locals: { posts: @posts }, formats: [:html]) }
      end # api for the infintite scroll
    end
  end

  def show
    @post = Post.find(params[:id])
    authorize @post
    @comment = Comment.new
    @language = @post.language
    set_slideshow_keywords
    render layout: "conversations"
  end

  def new
    @post = Post.new
    @post.language = @language
    authorize @post
    render layout: "conversations"
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post
    @language = @post.language
    set_slideshow_keywords
    render layout: "conversations"
  end

  def update
    @post = Post.find(params[:id])
    @language = @post.language
    authorize @post
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      set_slideshow_keywords
      render :edit, layout: "conversations"
    end
  end

  def create
    @language = Language.find(params[:post][:language_id])
    @post = Post.new(post_params)
    @post.user = current_user
    new_cp_total = current_user.convo_points + 5
    current_user.update(convo_points: new_cp_total)
    authorize @post
    if @post.save
      ActionCable.server.broadcast('posts', post: render_to_string(partial: 'posts/post', locals: { post: @post }))
      redirect_to post_path @post
    else
      set_slideshow_keywords
      render :new, layout: "conversations"
    end
  end

  private

  def post_params
    params.require(:post).permit(:language_id, :title, :content)
  end
end
