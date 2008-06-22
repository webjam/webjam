class Rsvp < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  validates_uniqueness_of [:event_id, :user_id]
end
