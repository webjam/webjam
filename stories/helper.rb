ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'spec/rails/story_adapter'

Dir[File.join(File.dirname(__FILE__), "steps/*.rb")].each do |file|
  require file
end

# Added these so that exceptions that occur in stories aren't handled by rails
ActionController::Base.class_eval do
  def perform_action
    perform_action_without_rescue
  end
end
Dispatcher.class_eval do
  def self.failsafe_response(output, status, exception = nil)
    raise exception
  end
end
