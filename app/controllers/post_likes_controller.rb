class PostLikesController < ApplicationController
    before_action :find_post
    before_action :find_like, only: [:destroy]
  
    def create
      if already_liked?
        flash[:notice] = "You have already liked this post."
      else
        @post.likes.create(user_id: current_user.id)
      end
      redirect_to post_path(@post)
    end
  
    def destroy
      if !already_liked?
        flash[:notice] = "Cannot unlike."
      else
        @like.destroy
      end
      redirect_to post_path(@post)
    end
  
    private
  
    def already_liked?
      Like.where(user_id: current_user.id, likeable: @post).exists?
    end
  
    def find_post
      @post = Post.find(params[:post_id])
    end
  
    def find_like
      @like = @post.likes.find(params[:id])
    end
  end
  