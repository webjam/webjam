require 'campaign_monitor'

class RsvpObserver < ActiveRecord::Observer
  def after_create(rsvp)
    send_thankyou_email(rsvp)
    subscribe_to_campaign_monitor(rsvp)
  end
  def send_thankyou_email(rsvp)
    EventRsvpMailer.deliver_rsvp_thankyou(rsvp)
  end
  def subscribe_to_campaign_monitor(rsvp)
    if list = campaign_monitor_list(rsvp.event)
      campaign_subscriber(rsvp.user).add_and_resubscribe(list.id)
    end
  end
  def campaign_monitor_list(event)
    if (client = campaign_monitor_client) && event.campaign_monitor_list_id
      client.lists.detect(nil) {|l| l.id == event.campaign_monitor_list_id}
    end
  end
  def campaign_subscriber(user)
    CampaignMonitor::Subscriber.new(user.email, user.full_name)
  end
  def campaign_monitor_client
    if api_key = APPLICATION_CONFIG.campaign_monitor_api_key
      CampaignMonitor.new(api_key)
    end
  end
end
