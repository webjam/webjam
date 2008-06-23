class PagesController < ApplicationController
  def home
    @upcoming_events = Event.published.upcoming(:order => "held_at DESC")
    @past_events = Event.published.past(:order => "held_at DESC")
    if iphone_request?
      render :action => "home_iphone", :layout => "iphone"
    else
      render
    end
  end
  def statichome
  end
  def contact
  end
  def openid
  end
end
