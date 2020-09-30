class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    authorize @comment
  end

  def create
    @post = Post.find(params[:post_id])
    @language = @post.language
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post = @post
    new_cp_total = current_user.convo_points + 2
    current_user.update(convo_points: new_cp_total)
    authorize @comment
    if @comment.save
      redirect_to post_path @post
    else
      render "posts/show", layout: "conversations"
    end
  end

  def show
    @comment = @post.comment
    authorize @comment
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id, :comment_id)
  end
end
