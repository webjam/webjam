class Event < ActiveRecord::Base
  has_many :rsvps
  has_many :presentation_proposals
  has_many :users, :through => :rsvps

  def upcoming?(now=Time.now.utc)
    self.held_at >= now
  end

  def full?
    self.rsvps.size >= (self.rsvp_limit || 0)
  end 

  def to_param
    self.tag
  end
end
