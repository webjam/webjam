class RsvpsController < ApplicationController
  before_filter :login_required

  def create
    @event = Event.find_by_tag(params[:event_id])
    raise NotFound unless @event
    if @event.full?
      redirect_to event_path(:id => @event, :event_full => true)
    end
    if current_user.rsvps.create(:event => @event)
      redirect_to event_path(@event)
    else
      redirect_to event_path(:id => @event, :already_rsvpd => true)
    end
  end
  
  def destroy
    event = Event.find_by_tag(params[:event_id])
    raise NotFound unless event
    rsvp = current_user.rsvps.find(params[:id])
    rsvp.destroy
    redirect_to event_path(event)
  end
end
