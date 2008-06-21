class Rsvp < ActiveRecord::Base
  belongs_to :Event
  belongs_to :user
end
