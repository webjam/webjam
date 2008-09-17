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
          render :action => "show_upcoming"
        else
          render :action => "show"
        end
      end
    end
  end
  def past_events
    @events = Event.published.past
  end
end
