require "../spec_helper"

describe Post, "before_save" do
  it "calls set_year" do
    p = Post.new
    p.should_receive(:set_year)
    p.save(false)
  end
end

describe Post, "set_year" do
  it "should not bork if no published_at set" do
    p = Post.new(:published_at => nil)
    lambda { p.set_year }.should_not raise_error
  end
  it "sets year to be published_at.year" do
    p = Post.new(:published_at => Time.utc(2008,01,01))
    p.set_year
    p.year.should == 2008
  end
end
