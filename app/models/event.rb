class Event < ActiveRecord::Base
  has_many :rsvps
  has_many :presentation_proposals
  has_many :users, :through => :rsvps

  def upcoming?(now=Time.now.utc)
    self.held_at >= now
  end

  def full?
    rsvps.size >= rsvp_limit
  end 
end
