Given "there is a post" do
  post(admin_user)
end

Given "there is a post with next, previous and comments" do
  @post = post(admin_user)
  @comment = comment(@post, admin_user)
  post_before(@post, admin_user)
  post_after(@post, admin_user)
end
