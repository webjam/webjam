class EventsController < ApplicationController
  before_filter :find_event, :only => [:show]
  def show
    render :action => (@event.upcoming? ? 'show_upcoming' : 'show_past')
  end

  def past
    @events = Event.find_past(:all)
  end

  protected
    def find_event
      @event = Event.find(params[:id])
    end
end