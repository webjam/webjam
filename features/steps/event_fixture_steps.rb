Given "there is a past event" do
  @event = Event.create!(
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

Given "there is an upcoming event" do
  @event = Event.create!(
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

Given "there is an unpublished event" do
  @event = Event.create!(
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
