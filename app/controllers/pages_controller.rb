class PagesController < ApplicationController
  def home
    @upcoming_events = Event.published.upcoming(:order => "held_at DESC")
    @past_events = Event.published.past(:order => "held_at DESC")
    @latest_post = Post.published.latest 
    if iphone_request?
      render :action => "home_iphone", :layout => "iphone"
    end
  end
  def contact
  end
  def openid
  end
  def contributors
  end
end
