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

When "I update my account details giving invalid details" do
  @new_account_details = {
    :nick_name => "",
    :full_name => "",
    :email => "",
    :website_url => "ftp://hellothere.com/"
  }
  put update_profile_details_current_user_path(:user => @new_account_details)
end

Then "my account details are updated" do
  @logged_in_user.reload
  @new_account_details.each_pair do |attr, new_value|
    @logged_in_user[attr].should == new_value
  end
end

Then "my account details aren't updated" do
  @logged_in_user.reload
  @new_account_details.each_pair do |attr, new_value|
    @logged_in_user[attr].should_not == new_value
  end
end

Then "I am redirected to the account page" do
  response.should redirect_to(user_path(@logged_in_user))
end

Then "I am shown the account edit page" do
  response.should be_success
  response.should render_template("users/edit")
end