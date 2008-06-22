class RsvpsController < ApplicationController
  before_filter :login_required

  def create
    @event = Event.find_by_tag(params[:event])
    render :text => 'full' and return if @event.full?
    if @rsvp = Rsvp.create({:event_id => @event.id, :user_id => current_user})
      #render :thank_you
      render :text => 'hawt'
    else
      render :text => 'nawt'
      #render :new
    end
  end
end
