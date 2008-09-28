When "I view the mobile post page" do
  post = Factory.create(:post)
  Factory.create(:post_comment, :commentable => post)
  Factory.create(:post, :published_at => post.published_at + 1.day)
  Factory.create(:post, :published_at => post.published_at - 1.day)
  get formatted_post_path(post.year, post.permalink, :mobile)
end

When "I view the post page" do
  post = Factory.create(:post)
  Factory.create(:post_comment, :commentable => post)
  Factory.create(:post, :published_at => post.published_at + 1.day)
  Factory.create(:post, :published_at => post.published_at - 1.day)
  get post_path(post.year, post.permalink)
end
