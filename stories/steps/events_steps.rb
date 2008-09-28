steps_for :events do
  Given "I am not logged in" do
  end
  
  Given "a past event exists" do
    @event = past_event
  end
  
  Given "an upcoming event exists" do
    @event = upcoming_event
  end
  
  Given "an unpublished event exists" do
    @event = unpublished_event
  end
  
  When "I view the event page" do
    get event_path(@event)
  end
  
  When "I view the mobile past events page" do
    get formatted_past_events_path(:mobile)
  end
  
  Then "I see the page" do
    response.should be_success
  end

  Then "I receive a 404 not found" do
    response.code.should == "404"
  end
  
end
