class PagesController < ApplicationController
  def home
    @past_events = Event.find_past(:all, :order => 'held_at ASC', :limit => 5)
    @posts = Post.find_published(:all, :order => 'published_at DESC', :limit => 1)
  end
  def about
  end
  def contact
  end
end
