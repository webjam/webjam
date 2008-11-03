require File.dirname(__FILE__) + "/../spec_helper"

describe Presenter, "name" do
  describe "if no user set" do
    it "is required" do
      Presenter.new.should have(1).error_on(:name)
    end
  end
  describe "if user set" do
    it "is not required" do
      p = Presenter.new
      p.user = User.new
      p.should have(0).errors_on(:name)
    end
  end
end

describe Presenter, "protected_attributes" do
  it "allows name, url to be mass assigned" do
    p = Presenter.new(:name => "Name", :url => "URL")
    p.name.should == "Name"
    p.url.should == "URL"
  end
  it "doesn't allow user to be mass assigned" do
    p = Presenter.new(:user => User.new)
    p.user.should be_nil
  end
end

describe Presenter, "name" do
  describe "with a user" do
    it "returns the user's full_name" do
      p = Presenter.new
      p.should_receive(:user).twice.and_return(mock("user", :full_name => :user_full_name))
      p.name.should == :user_full_name
    end
  end
  describe "with no user" do
    it "returns attributes.name" do
      p = Presenter.new(:name => "presenter_name")
      p.should_receive(:user).and_return(nil)
      p.name.should == "presenter_name"
    end
  end
end
