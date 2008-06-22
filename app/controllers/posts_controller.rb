class PostsController < ApplicationController
  def show
    @post = Post.published.find_by_permalink(params[:permalink])
  end
  
  def index
    @posts = Post.find_all_for_archive
  end
  
  def index_by_year
    @posts = Post.published.find_all_for_archive_by_year(params[:year].to_i)
    render :template => 'posts/index'
  end
  
  def legacy
    post = Post.find_legacy(params[:permalink])
    redirect_to post_url(:year => post.published_at.year, :permalink => post.permalink), 
                :status => 301
  end
end
