class Admin::ProposalsController < Admin::BaseController
  before_filter :load_event
  def index
    @proposals = @event.presentation_proposals.find(:all, :order => 'created_at DESC')
  end

  private
  def load_event
    @event = Event.find_by_tag(params[:event_id])
    raise NotFound unless @event
  end
end
