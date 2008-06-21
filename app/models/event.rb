class Event < ActiveRecord::Base
  has_many :rsvps
  has_many :users, :through => :rsvps
  def upcoming?(now=Time.now.utc)
    # TODO: Impelement
    true
  end

  def full?
    rsvps.size >= rsvp_limit
  end 
end
