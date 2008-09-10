require 'yaml'

class ApplicationConfig
  attr_reader :flickr_api_key,
              :jeeves_campfire_password,
              :campaign_monitor_api_key,
              :session_secret,
              :feed_url,
              :protected_domains,
              :protection_username,
              :protection_password,
              :excitement_notification_recipients
  
  def initialize
    y = YAML::load(File.open(File.dirname(__FILE__) + '/../config/application.yml'))
    @flickr_api_key = y['flickr_api_key']
    @jeeves_campfire_password = y['jeeves_campfire_password']
    @campaign_monitor_api_key = y['campaign_monitor_api_key']
    @session_secret = y['session_secret']
    @feed_url = y['feed_url'] ? y['feed_url'] : "/news.atom"
    @protected_domains = y['protected_domains']
    @protected_domains = [] unless @protected_domains
    @protection_username = y['protection_username']
    @protection_password = y['protection_password']
    @excitement_notification_recipients = y['excitement_notification_recipients']
  end
end
