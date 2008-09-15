steps_for :events do
  Given "I am not logged in" do
  end
  
  Given "a previous event exists" do
    previous_event
  end
  
  When "I view the past events pages from an iphone" do
    get formatted_past_events_path(:mobile), nil, :user_agent => iphone_user_agent
  end
  
  Then "I see the page" do
    response.should be_success
  end
end
