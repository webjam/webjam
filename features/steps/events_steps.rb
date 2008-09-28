When "I view the event page for a past event" do
  event = Factory.create(:event, :held_at => 1.day.ago, :proposals_close_at => 2.days.ago)
  get event_path(event)
end

When "I view the event page for an upcoming event" do
  event = Factory.create(:event, :held_at => Time.now.utc + 2.days, :proposals_close_at => Time.now.utc + 1.day)
  get event_path(event)
end

When "I view the event page for an unpublished event" do
  event = Factory.create(:event, :published_at => nil, :held_at => Time.now.utc, :proposals_close_at => Time.now.utc)
  get event_path(event)
end

When "I view the mobile past events page" do
  get formatted_past_events_path(:mobile)
end
