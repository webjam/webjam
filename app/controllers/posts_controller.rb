class PostsController < ApplicationController
  def show
    @post = Post.published.find_by_permalink(params[:permalink])
  end
  
  def index
    @posts = Post.find_all_for_archive
  end
  
  def index_for_year
    @posts = Post.published.find_all_by_year(params[:year])
  end
  
  def legacy
    post = Post.find_legacy(params[:permalink])
    redirect_to post_url(:year => post.published_at.year, :permalink => post.permalink), 
                :status => 301
  end
end
