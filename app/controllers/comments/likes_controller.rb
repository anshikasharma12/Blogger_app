# app/controllers/comments/likes_controller.rb
module Comments
    class LikesController < ApplicationController
      before_action :set_comment
  
      def create
        @comment.likes.create(user_id: current_user.id)
        redirect_to @comment.post
      end
  
      def destroy
        @comment.likes.where(user_id: current_user.id).destroy_all
        redirect_to @comment.post
      end
  
      private
  
      def set_comment
        @comment = Comment.find(params[:comment_id])
      end
    end
  end
  