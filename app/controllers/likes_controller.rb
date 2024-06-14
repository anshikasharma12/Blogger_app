class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @likeable = find_likeable
    @like = @likeable.likes.new(user: current_user)

    if @like.save
      redirect_back(fallback_location: root_path, notice: 'Liked!')
    else
      redirect_back(fallback_location: root_path, alert: 'Error liking item.')
    end
  end

  def destroy
    @likeable = find_likeable
    @like = @likeable.likes.find(params[:id])
    @like.destroy
    redirect_back(fallback_location: root_path, notice: 'Unliked!')
  end

  private

  def find_likeable
    if params[:post_id] && params[:comment_id]
      Comment.find(params[:comment_id])
    elsif params[:post_id]
      Post.find(params[:post_id])
    else
      raise ActiveRecord::RecordNotFound, "Couldn't find the likeable entity"
    end
  end
end
