class EventRsvpMailer < ActionMailer::Base
  
  def rsvp_thankyou(rsvp, sent_at = Time.now)
    subject    "You're coming to #{rsvp.event.name}"
    recipients rsvp.user.to_recipient
    from       rsvp.event.event_email_address
    sent_on    sent_at
    body       :rsvp => rsvp
  end

end
