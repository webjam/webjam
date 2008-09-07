require "../spec_helper"

describe RsvpObserver, "#after_save" do
  before do
    @observer = RsvpObserver.instance
    @observer.stub!(:send_thankyou_email)
    @observer.stub!(:subscribe_to_campaign_monitor)
  end
  it "calls send_thankyou_email" do
    rsvp = mock("rsvp")
    @observer.should_receive(:send_thankyou_email).with(rsvp)
    @observer.after_create(rsvp)
  end
  it "calls subscribe_to_campaign_monitor" do
    rsvp = mock("rsvp")
    @observer.should_receive(:subscribe_to_campaign_monitor).with(rsvp)
    @observer.after_create(rsvp)
  end
end

describe RsvpObserver, "#send_thankyou_email" do
  it "calls EventRsvpMailer.deliver_rsvp_thankyou" do
    observer = RsvpObserver.instance
    rsvp = mock("rsvp")
    EventRsvpMailer.should_receive(:deliver_rsvp_thankyou).with(rsvp)
    observer.send_thankyou_email(rsvp)
  end
end

describe RsvpObserver, "#subscribe_to_campaign_monitor" do
  it "calls campaign_monitor_list" do
    pending
  end
  describe "if theres no list" do
    it "does not subscribe the user" do
      pending
    end
  end
  describe "if theres a list" do
    it "calls campaign_subscriber" do
      pending
    end
    it "calls the subscriber's add_and_resubscribe" do
      pending
    end
  end
end

describe RsvpObserver, "#campaign_monitor_list" do
  describe "if campaign_monitor_client returns nil" do
    it "does not subscribe the user" do
      pending
    end
  end
  describe "if the event has no list id" do
    it "does not subscribe the user" do
      pending
    end
  end
  describe "if campaign_monitor_client returns the a client" do
    it "returns the client's list with matching list id" do
      pending
    end
  end
end

describe RsvpObserver, "#campaign_subscriber" do
  it "returns a new CampaignMonitor::Subscriber with the username and email" do
    pending
  end
end

describe RsvpObserver, "#campaign_monitor_client" do
  describe "if no API key exists" do
    it "returns nil" do
      pending
    end
  end
  describe "if an API key exists" do
    it "returns a new CampaignMonitor" do
      pending
    end
  end
end