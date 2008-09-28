Given "there is a post" do
  Factory.create(:post)
end

Given "there is a post with next, previous and comments" do
  post = Factory.create(:post)
  Factory.create(:post_comment, :commentable => post)
  Factory.create(:post, :published_at => post.published_at + 1.day)
  Factory.create(:post, :published_at => post.published_at - 1.day)
end
