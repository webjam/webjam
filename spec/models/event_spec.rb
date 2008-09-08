require "../spec_helper"

describe Event, "event_email_address" do
  it "returns <tag>@webjam.com.au" do
    Event.new(:tag => "webjam8").event_email_address.should == "webjam8@webjam.com.au"
  end
end