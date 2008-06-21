class Event < ActiveRecord::Base
  def upcoming?(now=Time.now.utc)
    self.held_at >= now
  end
end
