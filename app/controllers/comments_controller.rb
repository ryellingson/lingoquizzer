class CommentsController < ApplicationController
  def new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)

    if @comment.save
      redirect_to @post
    else
      render :new
    end
  end

  def show
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id )
  end
end
