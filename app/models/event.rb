class Event < ActiveRecord::Base
  def upcoming?(now=Time.now.utc)
    # TODO: Impelement
    true
  end
end
