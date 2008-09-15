ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'spec/rails/story_adapter'

Dir[File.join(File.dirname(__FILE__), "steps/*.rb")].each do |file|
  require file
end

require File.join(File.dirname(__FILE__), "webjam_story_fixtures")
Spec::Story::World.send :include, WebjamStoryFixtures

Spec::Story::World.class_eval do
  def iphone_user_agent
    "Mozilla/5.0 (iPhone; U; CPU like Mac OS X; en) AppleWebKit/420+ (KHTML, like Gecko) Version/3.0 Mobile/1A543a Safari/419.3"
  end
end
