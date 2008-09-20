module WebjamStoryFixtures
  def unpublished_event
    Event.create!(
      :name => "Webjam 1",
      :tag => "webjam1",
      :location => "Sydney",
      :hype => "<p>Buy it.</p>",
      :timezone => "Sydney",
      :published_at => nil, # not published
      :map_iframe_url => "http://iframe.com",
      :map_url => "http://map.com",
      :proposals_close_at => Time.now.utc - 5.days,
      :held_at => Time.now.utc - 1.day
    )
  end
  def past_event
    Event.create!(
      :name => "Webjam 7",
      :tag => "webjam7",
      :location => "Sydney",
      :hype => "<p>Buy it.</p>",
      :timezone => "Sydney",
      :published_at => Time.now.utc,
      :map_iframe_url => "http://iframe.com",
      :map_url => "http://map.com",
      :proposals_close_at => Time.now.utc - 5.days,
      :held_at => Time.now.utc - 1.day
    )
  end
  def upcoming_event
    Event.create!(
      :name => "Webjam 8",
      :tag => "webjam8",
      :location => "Sydney",
      :hype => "<p>Buy it.</p>",
      :timezone => "Sydney",
      :published_at => Time.now.utc,
      :map_iframe_url => "http://iframe.com",
      :map_url => "http://map.com",
      :proposals_close_at => Time.now.utc + 1.days,
      :held_at => Time.now.utc + 5.days
    )
  end
  def admin_user
    @user ||= begin
      user = User.new(
        :nick_name => "god",
        :email => "god@heaven.com",
        :full_name => "The Big G"
      )
      user.admin = true
      user.save!
      user
    end
  end
  def post(user)
    post = user.posts.create!(
      :title => "The greatest post",
      :body => "<p>What is it about the greatest post</p>",
      :published_at => Time.now.utc,
      :permalink => "some-great-post"
    )
  end
  def post_before(post, user)
    post = post(user)
    post.update_attribute(:created_at, post.created_at - 1.day)
    post
  end
  def post_after(post, user)
    post = post(user)
    post.update_attribute(:created_at, post.created_at + 1.day)
    post
  end
  def comment(post, user)
    comment = post.comments.build(:body => "Me too!")
    comment.user = user
    comment.save!
    comment
  end
end
