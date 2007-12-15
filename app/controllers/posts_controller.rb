class PostsController < ApplicationController
  before_filter :strip_permalinks
  def show
    @post = Post.find_published(params[:id])
  end
  def index
    @posts = Post.find_published(:all, :order => 'published_at DESC', :limit => 10)
  end
end
