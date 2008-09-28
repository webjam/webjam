Given "I am not logged in" do
end

Given "I am logged in" do
  @logged_in_user = Factory.create(:user)
  Factory.create(:identity_url, :user => @logged_in_user)
  login(@logged_in_user)
end
