class Jam < ActiveRecord::Base
  belongs_to :event
  has_and_belongs_to_many :presenters, :class_name => 'User', :foreign_key => 'user_id', :join_table => 'jams_users'
end
