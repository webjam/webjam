class RsvpsController < ApplicationController
  before_filter :login_required

  def show
    @event = Event.find_by_tag(params[:event_id])
    raise NotFound unless @event
    @rsvp = current_user.rsvp_for(@event)
    render :action => (@rsvp ? :show : :new)
  end
  
  def update
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
    if rsvp = current_user.rsvp_for(event)
      rsvp.destroy
    end
    redirect_to event_path(event)
  end
end
