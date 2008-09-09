require 'campaign_monitor'

class RsvpObserver < ActiveRecord::Observer
  def after_create(rsvp)
    send_thankyou_email(rsvp)
    subscribe_to_campaign_monitor(rsvp)
  end
  def after_destroy(rsvp)
    unsubscribe_from_campaign_monitor(rsvp)
  end
  def send_thankyou_email(rsvp)
    EventRsvpMailer.deliver_rsvp_thankyou(rsvp)
  end
  def subscribe_to_campaign_monitor(rsvp)
    if (list_id = rsvp.event.campaign_monitor_list_id) && (client = campaign_monitor_client)
      client.add_subscriber(list_id, rsvp.user.email, rsvp.user.full_name)
    end
  end
  def unsubscribe_from_campaign_monitor(rsvp)
    if (list_id = rsvp.event.campaign_monitor_list_id) && (client = campaign_monitor_client)
      client.remove_subscriber(list_id, rsvp.user.email)
    end
  end
  def campaign_monitor_client
    if api_key = APPLICATION_CONFIG.campaign_monitor_api_key
      CampaignMonitor.new(api_key)
    end
  end
end
