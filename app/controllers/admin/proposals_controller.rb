class Admin::ProposalsController < Admin::BaseController
  before_filter :load_event
  def index
    @proposals = @event.presentation_proposals.find(:all, :order => 'created_at DESC')
  end
  # def destroy
  #     Rsvp.find(params[:id]).destroy
  #     redirect_to admin_event_rsvps_path(@event)
  #   end
  private
  def load_event
    @event = Event.find_by_tag(params[:event_id])
  end
end
