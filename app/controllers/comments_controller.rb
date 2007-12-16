class CommentsController < ApplicationController
  before_filter :login_required
  def create
    @post = Post.find_published(params[:post_id])
    @comment = @post.comments.build(params[:comment])
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@post)+"#comment-#{@comment.id}"
    else
      redirect_to post_path(:id => @post, :no_body_error => true) + "#new-comment"
    end
  end
end
