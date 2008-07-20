class PresentationProposalsController < ApplicationController
  before_filter :login_required
  def new
    @event = Event.find_by_tag(params[:event_id])
    raise NotFound unless @event
    @proposal = @event.presentation_proposals.new(params[:presentation_proposal])
  end
  def create
    @event = Event.find_by_tag(params[:event_id])
    raise NotFound unless @event
    @proposal = @event.presentation_proposals.build(params[:presentation_proposal])
    @proposal.user = current_user
    if @proposal.save
      redirect_to event_path(@event)
    else
      render :action => :new
    end
  end
end
