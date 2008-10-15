require File.dirname(__FILE__) + "/../spec_helper"

describe Presenter, "name" do
  describe "if no user set" do
    it "is required" do
      Presenter.new.should have(1).error_on(:name)
    end
  end
  describe "if no user set" do
    it "is required" do
      p = Presenter.new
      p.user = User.new
      p.should have(0).errors_on(:name)
    end
  end
end
