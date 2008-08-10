class PresentationProposalsController < ApplicationController
  before_filter :login_required
  def edit
    @event = Event.find_by_tag(params[:event_id])
    raise NotFound unless @event
    @proposal = @event.presentation_proposals.find_by_user_id(current_user) || @event.presentation_proposals.build(:user => current_user)
    render_edit_or_new
  end
  def update
    @event = Event.find_by_tag(params[:event_id])
    raise NotFound unless @event
    @proposal = @event.presentation_proposals.find_by_user_id(current_user) || @event.presentation_proposals.build(:user => current_user)
    raise NotFound unless @event
    @proposal.attributes = params[:presentation_proposal]
    if @proposal.valid?
      @proposal.save
      redirect_to event_path(@event)
    else
      render_edit_or_new
    end
  end
  def destroy
    @event = Event.find_by_tag(params[:event_id])
    raise NotFound unless @event
    proposal = @event.presentation_proposals.find_by_user_id(current_user)
    raise NotFound unless proposal
    proposal.destroy
    redirect_to event_path(@event)
  end
  
  private
    def render_edit_or_new
      @proposal.new_record? ? render(:action => :new) : render(:action => :edit)
    end
end
