When "I view an events presentations page" do
  @event = Factory.create(:past_event)
  get event_presentations_path(@event)
end

When "I view an event presentation page" do
  @event = Factory.create(:past_event)
  @presentation = Factory.create(:presentation, :event => @event)
  get event_presentation_path(@event, @presentation)
end

When "I view a mobile event presentation page" do
  @event = Factory.create(:past_event)
  @presentation = Factory.create(:presentation, :event => @event)
  get formatted_event_presentation_path(@event, @presentation, :mobile)
end

Then "I am redirected to the event" do
  response.should redirect_to(event_path(@event))
end
