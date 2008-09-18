class EventsController < ApplicationController
  def show
    @event = Event.published.find_by_tag(params[:id])
    raise NotFound unless @event
    respond_to do |wants|
      wants.html do
        render :action => (@event.upcoming? ? "show_upcoming" : "show")
      end
      wants.mobile do
        if @event.upcoming?
          @previous_event = @event.previous
          @photos = @event.flickr_photos.latest.paginate :page => 1, :order => "created_at DESC"
          @latest_photo = @photos.first
          if @photos.empty? && @previous_event
            @photos_from_previous_event = true
            @photos = @previous_event.flickr_photos.featured.paginate :page => 1, :order => "created_at DESC"
            @latest_photo = @photos.first
          end
          @total_tweets = @event.tweets.count
          @latest_tweets = @event.tweets.latest(5).all
          @more_tweets = @event.tweets.count > @total_tweets
          render :action => "show_upcoming"
        else
          @photos = @event.flickr_photos.latest.paginate :page => 1, :order => "created_at DESC"
          @latest_photo = @photos.first
          @total_tweets = @event.tweets.count
          @latest_tweets = @event.tweets.latest(5).all
          @more_tweets = @event.tweets.count > @total_tweets
          render :action => "show"
        end
      end
    end
  end
  def past_events
    @events = Event.published.past
  end
end
