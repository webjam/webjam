When "I view the home page" do
  get home_path
end

When "I view the home page from an iphone" do
  get home_path, nil, :user_agent => iphone_user_agent
end

When "I view the home page from an iphone specifying redirect-to-mobile=no" do
  get home_path("redirect-to-mobile" => "no"), nil, :user_agent => iphone_user_agent
end

When "I view the mobile version of the home page" do
  get formatted_home_path(:mobile)
end

Then "I am redirected to the mobile page" do
  response.should redirect_to(formatted_home_path(:mobile))
end

Then "I am not redirected to the mobile page" do
  response.should_not be_redirect
end