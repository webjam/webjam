steps_for :about do
  Given "there is a past event" do
    past_event
  end
  
  Given "there is an upcoming event" do
    upcoming_event
  end
  
  When "I view the about page from my iphone" do
    get home_path, nil, :user_agent => iphone_user_agent
  end
  
  Then "I see the page" do
    response.should be_success
  end
end
