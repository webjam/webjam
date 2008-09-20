steps_for :posts do
  Given "a post with next, previous and comments" do
    @post = post(admin_user)
    @comment = comment(@post, admin_user)
    post_before(@post, admin_user)
    post_after(@post, admin_user)
  end
  
  Given "a previous event" do
    past_event
  end
  
  Given "I am logged in" do
    login(admin_user)
  end
  
  When "I view the post from my iphone" do
    get formatted_post_path(@post.year, @post.permalink, :mobile), nil, :user_agent => iphone_user_agent
  end
  
  Then "I see the page" do
    response.should be_success
  end
end
