class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:home, :about, :show]
  before_action :authorize_admin, only: [:edit, :update, :destroy]

  def home
    @posts = Post.all
  end

  def about
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, notice: "Post was successfully destroyed."
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_admin
    unless current_user.admin? || current_user == @post.user
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
