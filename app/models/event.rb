class Event < ActiveRecord::Base
  def self.find_upcoming(*options)
    with_scope(:find => {:conditions => ['held_at >= ?', Time.now.utc]}) { find(*options) }
  end
  def self.find_past(*options)
    with_scope(:find => {:conditions => ['held_at < ?', Time.now.utc]}) { find(*options) }
  end
  def upcoming?
    self.held_at >= Time.now.utc
  end
  def past?
    !upcoming?
  end
  def to_s
    "#{city} (#{held_at.to_date.to_s(:short)})"
  end
end
