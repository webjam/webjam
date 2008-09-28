When "I view the mobile post page" do
  post = Factory.create(:post)
  get formatted_post_path(post.year, post.permalink, :mobile)
end
