class CommentLikesController < ApplicationController
    before_action :find_comment
    before_action :find_like, only: [:destroy]
  
    def create
      if already_liked?
        flash[:notice] = "You have already liked this comment."
      else
        @comment.likes.create(user_id: current_user.id)
      end
      redirect_to post_path(@comment.post)
    end
  
    def destroy
      if !already_liked?
        flash[:notice] = "Cannot unlike."
      else
        @like.destroy
      end
      redirect_to post_path(@comment.post)
    end
  
    private
  
    def already_liked?
      Like.where(user_id: current_user.id, likeable: @comment).exists?
    end
  
    def find_comment
      @comment = Comment.find(params[:comment_id])
    end
  
    def find_like
      @like = @comment.likes.find(params[:id])
    end
  end
  