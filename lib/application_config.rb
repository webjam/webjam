require 'yaml'

class ApplicationConfig
  attr_reader :flickr_api_key,
              :jeeves_campfire_password,
              :campaign_monitor_api_key,
              :session_secret,
              :feed_url
  
  def initialize
    y = YAML::load(File.open(File.dirname(__FILE__) + '/../config/application.yml'))
    @flickr_api_key = y['flickr_api_key']
    @jeeves_campfire_password = y['jeeves_campfire_password']
    @campaign_monitor_api_key = y['campaign_monitor_api_key']
    @session_secret = y['session_secret']
    @feed_url = y['feed_url'] ? y['feed_url'] : "/news.atom"
  end
end
