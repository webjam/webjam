class Admin::PostsController < Admin::BaseController
  def index
    @posts = Post.find(:all, :order => 'published_at DESC')
  end
  def new
    @post = Post.new
  end
  def create
    @post = Post.new(params[:post])
    @post.save!
    redirect_to [:admin, @post]
  end
  def edit
    @post = Post.find(params[:id])
  end
  def update
    @post = Post.find(params[:id])
    @post.attributes = params[:post]
    @post.save!
    redirect_to [:admin, @post]
  end
  def destroy
    Post.find(params[:id]).destroy
    redirect_to admin_posts_path
  end
  def show
    @post = Post.find(params[:id])
  end
end
