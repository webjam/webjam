require 'campaign_monitor'

class PresentationProposalObserver < ActiveRecord::Observer
  def after_create(proposal)
    send_excitment_email(proposal)
  end
  def send_excitment_email(proposal)
    event = proposal.event
    ExcitementMailer.deliver_proposals(event, proposal)
  end
end
