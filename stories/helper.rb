ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'spec/rails/story_adapter'

Dir[File.join(File.dirname(__FILE__), "steps/*.rb")].each do |file|
  require file
end

# Added these so that exceptions that occur in stories aren't handled by rails
ActionController::Base.class_eval do
  def perform_action_with_rescue #:nodoc:
    perform_action_without_rescue
  rescue Exception => exception
    rescue_action_with_handler(exception) || raise
  end
end

Dispatcher.class_eval do
  def self.failsafe_response(output, status, exception = nil)
    raise exception
  end
end

require File.join(File.dirname(__FILE__), "webjam_story_fixtures")

Spec::Story::World.class_eval do
  include WebjamStoryFixtures

  def iphone_user_agent
    "Mozilla/5.0 (iPhone; U; CPU like Mac OS X; en) AppleWebKit/420+ (KHTML, like Gecko) Version/3.0 Mobile/1A543a Safari/419.3"
  end
  def login(user)
    pending
  end
end
