class PostsController < ApplicationController
  def show
    @post = Post.find_published(params[:id])
  end
  
  def index
    @posts = Post.find_all_for_archive
  end
  
  def index_for_year
  end
  
  def legacy
    post = Post.find_legacy(params[:permalink])
    redirect_to post_path(post), :status => 301
  end
end
