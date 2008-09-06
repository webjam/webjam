require "../spec_helper"

describe Rsvp, "event and user uniqueness validation" do
  before do
    @event = Event.new
    @event.save(false)
    @user = User.new
    @user.save(false)
  end
  it "fails if RSVP exists duplicate user and event" do
    Rsvp.create!(:event => @event, :user => @user)
    rsvp = Rsvp.new(:event => @event, :user => @user)
    rsvp.should have(1).error_on(:event_id)
  end
  it "passes if new user and event" do
    rsvp = Rsvp.new(:event => @event, :user => @user)
    rsvp.should have(0).errors_on(:event_id)
  end
  it "passes if RSVP for user exists but different event" do
    Rsvp.create!(:event => @event, :user => @user)
    event_2 = Event.new
    event_2.save(false)
    Rsvp.new(:event => event_2, :user => @user).should have(0).errors_on(:event_id)
  end
  it "has no errors if RSVP for event exists but different user" do
    Rsvp.create!(:event => @event, :user => @user)
    user_2 = User.new
    user_2.save(false)
    Rsvp.new(:event => @event, :user => user_2).should have(0).errors_on(:event_id)
  end
end