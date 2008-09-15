class PagesController < ApplicationController
  def home
    if redirect_to_mobile?
      redirect_to formatted_home_path(:mobile)
      return
    end
    respond_to do |wants|
      wants.html do
        @upcoming_events = Event.published.upcoming(:order => "held_at DESC")
        @past_events = Event.published.past(:order => "held_at DESC")
      end
      wants.mobile do
        @upcoming_events = Event.published.upcoming(:order => "held_at DESC")
        @last_post = Post.published.first(:order => "published_at DESC")
      end
    end
  end
  def contact
  end
  def openid
  end
  def contributors
  end
  def about
    redirect_to home_path, :status => 301
  end
  
  protected
    def redirect_to_mobile?
      mobile_request? && request.format != "mobile" && params["redirect-to-mobile"] != "no"
    end
end
