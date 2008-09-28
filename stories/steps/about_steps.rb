steps_for :about do
  Given "there is a past event" do
    past_event
  end
  
  Given "there is an upcoming event" do
    upcoming_event
  end
  
  When "I view the mobile about page" do
    get formatted_about_path(:mobile)
  end
  
  Then "I see the page" do
    response.should be_success
  end
end
