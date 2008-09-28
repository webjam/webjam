When "I view the event page" do
  get event_path(@event)
end

When "I view the mobile past events page" do
  get formatted_past_events_path(:mobile)
end

