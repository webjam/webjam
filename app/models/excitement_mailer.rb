class ExcitementMailer < ActionMailer::Base
  

  def rsvps(event, rsvps, sent_at = Time.now)
    subject    "[Webjam] Get excited about RSVP's!'"
    recipients APPLICATION_CONFIG.excitement_notification_recipients
    from       'webjam@webjam.com.au'
    sent_on    sent_at
    
    body       :event => event, :rsvps => rsvps
  end

  def proposals(event, proposal, sent_at = Time.now)
    subject    "[Webjam] Holy moly there's a new proposal!"
    recipients APPLICATION_CONFIG.excitement_notification_recipients
    from       'webjam@webjam.com.au'
    sent_on    sent_at
    
    body       :event => event, :proposal => proposal
  end

end
