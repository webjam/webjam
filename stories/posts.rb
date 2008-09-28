require File.join(File.dirname(__FILE__), "story_helper")

with_steps_for :posts do
  run File.expand_path(__FILE__).gsub("rb", "story"), :type => RailsStory
end
