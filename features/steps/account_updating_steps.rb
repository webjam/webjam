When "I view the account page" do
  get edit_current_user_path
end

When "I update my account details" do
  @new_account_details = {
    :nick_name => "new_nick_name",
    :full_name => "New full name",
    :email => "new_email@address.com",
    :website_name => "New website name",
    :website_url => "http://new.website.com/",
    :description => "New description",
  }
  put update_profile_details_current_user_path(:user => @new_account_details)
end

Then "my account details are updated" do
  @logged_in_user.reload
  [:nick_name, :full_name, :email, :website_name, :website_url, :description].each do |attr|
    @logged_in_user[attr].should == @new_account_details[attr]
  end
end

Then "I am redirected to the account page" do
  response.should redirect_to(user_path(@logged_in_user))
end
