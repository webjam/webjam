Then "I see the page" do
  response.should be_success
end

Then "I receive a 404 not found" do
  response.code.should == "404"
end

Then "I don't see an exception" do
  response.should be_success
end
