class CommentsController < ApplicationController
  def create
    @post = Post.find_published(params[:post_id])
    @comment = @post.comments.build(params[:comment])
    @comment.user = current_user
    if @post.save
      flash[:notice] = "Thanks! Comment added."
      redirect_to post_path(@post)+"#comment-#{@comment.id}"
    else
      redirect_to post_path(@post)+"#new-comment"
    end
  end
end
