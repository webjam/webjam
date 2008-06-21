class CommentsController < ApplicationController
  before_filter :login_required
  def create
    @post = Post.published.find_by_permalink(params[:permalink])
    @comment = @post.comments.build(params[:comment])
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(:year => @post.year, :permalink => @post.permalink)+"#comment-#{@comment.id}"
    else
      redirect_to post_path(:year => @post.year, :permalink => @post.permalink) + "#new-comment"
    end
  end
end
