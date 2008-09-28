require File.dirname(__FILE__) + "/../spec_helper"

describe Jam, "to_param" do
  it "returns number" do
    Jam.new(:number => 1).to_param.should == 1
  end
end
