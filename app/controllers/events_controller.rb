class EventsController < ApplicationController
  def show
    @event = Event.find_by_tag(params[:id])
    raise NotFound unless @event
    if @event.upcoming?
      render :action => "show_upcoming"
    else
      render :action => "show"
    end
  end
  def past_events
    @events = Event.published.past
  end
end
