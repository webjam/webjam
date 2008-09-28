Given "I am logged in" do
  user = Factory.create(:user)
  Factory.create(:identity_url, :user => user)
  login(user)
end

When "I view the mobile post page" do
  post = Factory.create(:post)
  get formatted_post_path(post.year, post.permalink, :mobile)
end
