require "../spec_helper"

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
    it "calls data on the response" do
      pending
    end
    it "calls self.class.attr_for_openid_sreg_field for each data field" do
      pending
    end
    it "sets the attributes" do
      pending
    end
  end
end

describe User, ".attr_for_openid_sreg_field(field)" do
  it "maps nickname to nick_name" do
    pending
  end
  it "maps email to email" do
    pending
  end
  it "maps fullname to full_name" do
    pending
  end
end
