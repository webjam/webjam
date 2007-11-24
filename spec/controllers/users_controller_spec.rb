require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController do
  fixtures :users
  it "should show new user page" do
    get :new
    assigns(:identity_url).should_not be_nil
  end
  it "should have a nil URL if none given in the URL" do
    get :new
    assigns(:identity_url).url.should be_nil
  end
  it "should use the URL if given in the URL" do
    get :new, :openid_url => "some_url"
    assigns(:identity_url).url.should eql("some_url")
  end
  it "should redirect verify to new_user_path if no openid_url specified or no openid transaction taking place" do
    post :verify
    response.should redirect_to(new_user_path)
  end
end

describe UsersController, " verifying an invalid identity URL" do
  before do
    @invalid_url = mock(IdentityUrl)
    @invalid_url.should_receive(:valid?).and_return(false)
    IdentityUrl.should_receive(:new).with(:url => "invalid_url").and_return(@invalid_url)
  end
  it "should assign an identity_url" do
    post :verify, :openid_url => "invalid_url"
    assigns(:identity_url).should eql(@invalid_url)
  end
  it "should render new" do
    post :verify, :openid_url => "invalid_url"
    response.should render_template("new")
  end
end

describe UsersController, " successfully verifying a valid identity URL" do
  before do
    valid_identity_url = mock("identity url")
    valid_identity_url.should_receive(:valid?).and_return(false)
    IdentityUrl.should_receive(:new).and_return(valid_identity_url)

    controller.should_receive(:authenticate_with_open_id).with(:some_url, {:optional => %w(fullname email nickname)}).and_return do
      result = mock("result")
      result.should_receive(:successful?).and_return(true)
      yield(:some_url, result, :some_sreg_fields)
    end
  end
  it "should store verified openid details in session" do
    post :verify, :openid_url => :some_url
    session[:verified_openid_details].should_not be_nil
  end
  it "should redirect to users details" do
    post :verify, :openid_url => :some_url
    response.should redirect_to(details_users_path)
  end
end
