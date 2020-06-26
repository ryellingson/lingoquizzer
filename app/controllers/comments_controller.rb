class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    authorize @comment
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    authorize @comment
    if @comment.save
      redirect_to @post
    else
      render :new
    end
  end

  def show
    @comment = @post.comment
    authorize @comment
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id )
  end
end
