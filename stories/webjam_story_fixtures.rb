module WebjamStoryFixtures
  def previous_event
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
    user = User.new(
      :nick_name => "god",
      :email => "god@heaven.com",
      :full_name => "The Big G"
    )
    user.admin = true
    user.save!
    user
  end
  def post(user)
    post = user.posts.create!(
      :title => "The greatest post",
      :body => "<p>What is it about the greatest post</p>",
      :published_at => Time.now.utc,
      :permalink => "some-great-post"
    )
  end
end
