class Admin::PostsController < Admin::BaseController
  def index
    @posts = Post.find(:all, :order => 'created_at DESC')
  end
  def new
    
  end
  def create
    
  end
  def edit
    
  end
  def update
    
  end
  def destroy

  end
end