class CommentsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]
  before_action :authorize_access, only: [:edit, :update, :destroy]

  # def new
  #   @comment = Comment.new
  # end

  def create
    # comment is linked to post, find the post
    @post = Post.find params[:post_id]
    comment_params = params.require(:comment).permit(:body)
    @comment = Comment.new comment_params

    @comment.user = current_user
    @comment.post = @post

    if @comment.save
      redirect_to post_path(@post)

      # redirect_to comment_path(@comment)
      # comments show page
    else
      render 'posts/show'
    end
  end

  def destroy
    @post = Post.find params[:post_id]
    @comment = Comment.find params[:id]

    if can? :modify, @comment
      @comment.destroy
      # redirect to the post that the comment was deleted from so they can still see the post
      redirect_to post_path(@post), notice: "Comment deleted."
    else
      redirect_to post_path(@post), alert: "Error deleting comment."
    end
    # don't need @post id when deleting
  end

private
def authorize_access
  redirect_to root_path, alert: "Access Denied" unless can? :modify, Comment
end

end
