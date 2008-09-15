steps_for :home do
  Given "I am not logged in" do
  end
  
  Given "an upcoming event exists" do
    upcoming_event
  end
  
  Given "a post exists" do
    post(admin_user)
  end
  
  When "I view the home page" do
    get home_path
  end
  
  When "I view the home page from an iphone" do
    get home_path, nil, :user_agent => "Mozilla/5.0 (iPhone; U; CPU like Mac OS X; en) AppleWebKit/420+ (KHTML, like Gecko) Version/3.0 Mobile/1A543a Safari/419.3"
  end
  
  When "I view the home page from an iphone specifying redirect-to-mobile=no" do
    get home_path("redirect-to-mobile" => "no"), nil, :user_agent => "Mozilla/5.0 (iPhone; U; CPU like Mac OS X; en) AppleWebKit/420+ (KHTML, like Gecko) Version/3.0 Mobile/1A543a Safari/419.3"
  end
  
  When "I view the mobile version of the home page" do
    get formatted_home_path(:mobile)
  end
  
  Then "I see the page" do
    response.should be_success
  end
  
  Then "I am redirected to the mobile page" do
    response.should redirect_to(formatted_home_path(:mobile))
  end
  
  Then "I am not redirected to the mobile page" do
    response.should_not be_redirect
  end
end