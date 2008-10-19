require File.dirname(__FILE__) + "/../spec_helper"

describe User, "#openid_sreg_fields=" do
  describe "passed nil" do
    before do
      @user = User.new
    end
    it "doesnt blow up" do
      lambda { @user.openid_sreg_fields=(nil) }.should_not raise_error
    end
    it "doesnt set any attribute" do
      @user.should_not_receive(:[]=)
      @user.openid_sreg_fields=(nil)
    end
  end
  describe "passed an rseg response" do
    before do
      @response = mock("sreg response")
      @response.stub!(:data).and_return({:key_1 => :value_1, :key_2 => :value_2 })
    end
    it "calls data on the response" do
      @response.should_receive(:data).and_return({})
      User.new(:openid_sreg_fields => @response)
    end
    it "calls self.class.attr_for_openid_sreg_field for each data field" do
      User.should_receive(:attr_for_openid_sreg_field).ordered.with(:key_1)
      User.should_receive(:attr_for_openid_sreg_field).ordered.with(:key_2)
      User.new(:openid_sreg_fields => @response)
    end
    it "sets the attributes" do
      u = User.new
      User.stub!(:attr_for_openid_sreg_field).with(:key_1).ordered.and_return(:attr_1)
      User.stub!(:attr_for_openid_sreg_field).with(:key_2).ordered.and_return(:attr_2)
      u.should_receive(:[]=).ordered.with(:attr_1, :value_1)
      u.should_receive(:[]=).ordered.with(:attr_2, :value_2)
      u.openid_sreg_fields = @response
    end
  end
end

describe User, ".attr_for_openid_sreg_field(field)" do
  it "maps nickname to nick_name" do
    User.attr_for_openid_sreg_field("nickname").should == "nick_name"
  end
  it "maps email to email" do
    User.attr_for_openid_sreg_field("email").should == "email"
  end
  it "maps fullname to full_name" do
    User.attr_for_openid_sreg_field("fullname").should == "full_name"
  end
end

describe User, "#to_recipient" do
  it "returns a string formatted \"Full Name\" <email>" do
    User.new(:full_name => "Morris Iemma", :email => "morris@hotmail.com").to_recipient.should == %("Morris Iemma" <morris@hotmail.com>)
  end
end

describe User, "website_url=" do
  it "adds http:// if none specified" do
    User.new(:website_url => "somewhere.com").website_url.should == "http://somewhere.com"
  end
  it "doesn't add http:// if has http:// already" do
    User.new(:website_url => "http://somewhere.com").website_url.should == "http://somewhere.com"
  end
  it "doesn't add http:// if has https:// already" do
    User.new(:website_url => "https://somewhere.com").website_url.should == "https://somewhere.com"
  end
end

describe User, "validations" do
  it "validates website_url isnt an ftp or javascript url" do
    %w( ftp://somewhere.com javascript:alert('hello') ).each do |invalid_url|
      User.new(:website_url => invalid_url).should have(1).error_on(:website_url)
    end
  end
  it "validates if website_url is http or https" do
    %w( http://somewhere.com https://somewhere.com ).each do |invalid_url|
      User.new(:website_url => invalid_url).should have(0).errors_on(:website_url)
    end
  end
  it "validates nick_name only has [a-zA-Z0-9-_]" do
    ['', ' ', 'a b', 'a.b', 'a$', 'a/'].each do |invalid_nick_name|
      User.new(:nick_name => invalid_nick_name).should have(1).error_on(:nick_name)
    end
  end
end