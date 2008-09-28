Given "I am logged in" do
  login(admin_user)
end

When "I view the mobile post page" do
  get formatted_post_path(@post.year, @post.permalink, :mobile)
end
