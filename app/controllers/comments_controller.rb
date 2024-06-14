class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:destroy]
  before_action :authenticate_user!

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: 'Comment was successfully created.' }
      else
        format.html { redirect_to @post, alert: @comment.errors.full_messages.join('. ') }
      end
    end
  end

  def destroy
    unless current_user.admin? || current_user == @comment.user
      redirect_to @post, alert: "You are not authorized to perform this action."
      return
    end

    @comment.destroy
    redirect_to @post, notice: 'Comment was successfully destroyed.'
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end
